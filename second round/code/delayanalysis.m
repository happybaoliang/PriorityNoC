function delayanalysis()
tic
N=4;% 4x4 mesh
P=5;% port number
F=4;% flow number

Times=5;
FbDelay=0;
BufSize=20;

pri=[2 3 4 1];
length=[8 8 8 8];
src_row=[1 1 1 3];
src_col=[4 3 1 4];
dst_col=[2 1 1 2];
dst_row=[2 3 4 2];

period=[24 24 24 24];
deadline=[10 20 30 40];

NIcell=cell(N,N);
flowcell=cell(F,1);
portcell=cell(5,1);
routercell=cell(N,N);

stageu=rtcpjdu(1,0,0);
stagel=rtcpjdl(1,0,0);

if FbDelay==0
    feedback=rtccurve([0 Inf 0]);
else
    feedback=rtccurve([[0 0 0];[FbDelay Inf 0]]);
end

first4stageSCL=rtcminconv(stagel,rtcminconv(stagel,rtcminconv(stagel,stagel)));
first4stageSCU=rtcminconv(stageu,rtcminconv(stageu,rtcminconv(stageu,stageu)));

mesh=struct('Router',routercell);
NIs=struct('ServiceCurve',NIcell,'Counter',NIcell,'FlowSet',NIcell);
router=struct('ServiceCurve',portcell,'Counter',portcell,'FlowSet',portcell);
flows=struct('FlowId',flowcell,'Source',flowcell,'Dest',flowcell,'Priority',flowcell,'Deadline',flowcell,'ArrivalCurve',flowcell,'Path',flowcell);

for i=1:1:N
    for j=1:1:N
        sc=struct('SCL',rtcpjdl(1,0,0),'SCU',rtcpjdu(1,0,0));
        NIs(i,j)=struct('ServiceCurve',sc,'Counter',0,'FlowSet',[]);
        for k=1:1:P
            router(k)=struct('ServiceCurve',sc,'Counter',0,'FlowSet',[]);
        end
        mesh(i,j).Router=router;
    end
end

for i=1:1:F
    dest=struct('Row',dst_row(i),'Col',dst_col(i));
    source=struct('Row',src_row(i),'Col',src_col(i));
    facl(i)=rtcscale(rtcpjdl(period(i),0,0),length(i),0);
    facu(i)=rtcscale(rtcpjdu(period(i),0,0),length(i),0);
    
    routine=FillPath(source,dest,BufSize);
    
    ac=struct('ACL',facl(i),'ACU',facu(i));
    
    for j=1:1:size(routine,2)
        portId=routine(j).port;
        routerId=routine(j).router;
        temp=mesh(routerId.Row,routerId.Col).Router(portId).FlowSet;
        mesh(routerId.Row,routerId.Col).Router(portId).FlowSet=[temp,struct('FlowId',i,'Priority',pri(i),'ArrivalCurve',ac)];
    end
    
    NIs(source.Row,source.Col).Counter=0;
    temp=NIs(source.Row,source.Col).FlowSet;
    NIs(source.Row,source.Col).FlowSet=[temp,struct('FlowId',i,'Priority',pri(i),'ArrivalCurve',ac)];
    flows(i)=struct('FlowId',i,'Source',source,'Dest',dest,'Priority',pri(i),'Deadline',deadline(i),'ArrivalCurve',ac,'Path',routine);
end

[~,index]=sort([flows.Priority]);

for i=1:1:F
    src_addr=flows(index(i)).Source;
    counter=NIs(src_addr.Row,src_addr.Col).Counter;
    tsc=NIs(src_addr.Row,src_addr.Col).ServiceCurve;
    [mask,cardinality]=CreateEqMask(flows(index(i)).Priority,NIs(src_addr.Row,src_addr.Col).FlowSet);
    if (counter+1)==cardinality
        NIs(src_addr.Row,src_addr.Col).Counter=0;
        tac=SumAC(mask,NIs(src_addr.Row,src_addr.Col).FlowSet);
        NIs(src_addr.Row,src_addr.Col).ServiceCurve=LeftOverSC(tsc,tac);        
    else
        NIs(src_addr.Row,src_addr.Col).Counter=counter+1;
    end
    
    fsc.SCU=rtcceil(rtcscale(tsc.SCU,1/cardinality,0));
    fsc.SCL=rtcfloor(rtcscale(tsc.SCL,1/cardinality,0));
    
    fc.SCL=[rtccurve([0 Inf 0])];
    fc.SCU=[rtccurve([0 Inf 0])];
    
    routine=flows(index(i)).Path;
    for j=size(routine,2):-1:1
        portId=routine(j).port;
        routerId=routine(j).router;
        flowset=mesh(routerId.Row,routerId.Col).Router(portId).FlowSet;
        [~,cardinality]=CreateEqMask(flows(index(i)).Priority,flowset);
        rsc=mesh(routerId.Row,routerId.Col).Router(portId).ServiceCurve;
        
        scu=rtcceil(rtcscale(rsc.SCU,1/cardinality,0));
        scl=rtcfloor(rtcscale(rsc.SCL,1/cardinality,0));
        
        ffscl=rtcminconv(first4stageSCL,rtcminconv(scl,rtcminconv(fc.SCL(1),stagel)));
        ffscu=rtcminconv(first4stageSCU,rtcminconv(scu,rtcminconv(fc.SCU(1),stageu)));
        
        routine(j).ServiceCurve.SCL=ffscl;
        routine(j).ServiceCurve.SCU=ffscu;
        
        pscl=rtcminconv(ffscl,feedback);
        pscu=rtcminconv(ffscu,feedback);
        
        buffersize=routine(j).BufSize;
        
        fc.SCL=rtcmatminclos(pscl,buffersize,Times);
        fc.SCU=rtcmatminclos(pscu,buffersize,Times);
    end
    
    NIscl=rtcminconv(fsc.SCL,fc.SCL(1));
    NIscu=rtcminconv(fsc.SCU,fc.SCU(1));
    
    tempSCL=NIscl;
    tempSCU=NIscu;
    for j=1:1:size(routine,2)
        portId=routine(j).port;
        routerId=routine(j).router;
        [~,cardinality]=CreateGeqMask(flows(index(i)).Priority,mesh(routerId.Row,routerId.Col).Router(portId).FlowSet);
        if cardinality>0
            acl=flows(index(i)).ArrivalCurve.ACL;
            acu=flows(index(i)).ArrivalCurve.ACU;
            betal=rtcminconv(tempSCL,first4stageSCL);
            betau=rtcminconv(tempSCU,first4stageSCU);
            alphal=rtcmin(rtcminconv(rtcmindeconv(acl,betau),betal),betal);
            alphau=rtcmin(rtcmindeconv(rtcminconv(acu,betau),betal),betau);
            UpdateAC(mesh(routerId.Row,routerId.Col).Router(portId).FlowSet,index(i),alphal,alphau);
            
            counter=mesh(routerId.Row,routerId.Col).Router(portId).Counter;
            [mask,cardinality]=CreateEqMask(flows(index(i)).Priority,mesh(routerId.Row,routerId.Col).Router(portId).FlowSet);
            if (counter+1)==cardinality
                mesh(routerId.Row,routerId.Col).Router(portId).Counter=0;
                tsc=mesh(routerId.Row,routerId.Col).Router(portId).ServiceCurve;
                tac=SumAC(mask,mesh(routerId.Row,routerId.Col).Router(portId).FlowSet);
                mesh(routerId.Row,routerId.Col).Router(portId).ServiceCurve=LeftOverSC(tsc,tac); 
            else
                mesh(routerId.Row,routerId.Col).Router(portId).Counter=counter+1;
            end
        end
        tempSCL=rtcminconv(tempSCL,routine(j).ServiceCurve.SCL);
        tempSCU=rtcminconv(tempSCU,routine(j).ServiceCurve.SCU);
    end
    fprintf('Delay Bound for Flow %3d: %3.3f cycles\n',index(i),rtch(flows(index(i)).ArrivalCurve.ACU,tempSCL));
end
toc
end

function UpdateAC(flowset,index,alphal,alphau)
    for i=1:1:size(flowset,2)
        if flowset(i).FlowId==index
            flowset(i).ArrivalCurve.ACL=alphal;
            flowset(i).ArrivalCurve.ACU=alphau;
        end
    end
end

function [mask,cardinality]=CreateEqMask(priority,flowset)
    mask=[];
    for i=1:1:size(flowset,2)
        if priority==flowset(i).Priority
            mask=[mask 1];
        else
            mask=[mask 0];
        end
    end
    cardinality=sum(mask);
end

function [mask,cardinality]=CreateGeqMask(priority,flowset)
    mask=[];
    for i=1:1:size(flowset,2)
        if priority<flowset(i).Priority
            mask=[mask 1];
        else
            mask=[mask 0];
        end
    end
    cardinality=sum(mask);
end

function sc=LeftOverSC(tsc,tac)
    sc.SCL=rtcmaxconv(rtcminus(tsc.SCL,tac.ACU),0);
    sc.SCU=rtcmax(rtcmaxdeconv(rtcminus(tsc.SCU,tac.ACL),0),0);
end

function totalAC=SumAC(mask,flowset)
    totalAC.ACL=rtccurve([0 0 0]);
    totalAC.ACU=rtccurve([0 0 0]);
    
    for i=1:1:size(flowset,2)
        if mask(i)
            totalAC.ACL=rtcplus(totalAC.ACL,flowset(i).ArrivalCurve.ACL);
            totalAC.ACU=rtcplus(totalAC.ACU,flowset(i).ArrivalCurve.ACU);
        end
    end
end