f1_buf_r10=1;
f1_buf_r14=0;
f1_buf_r15=0;
f1_buf_r16=0;

f2_buf_r15=1;
f2_buf_r14=0;
f2_buf_r13=0;
f2_buf_r9=0;
f2_buf_r5=0;

f3_buf_r1=1;
f3_buf_r5=0;
f3_buf_r139=0;

length=2;
period=length*6;
Deadline=[10 10 10 10];


scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

acl=rtcscale(rtcpjdl(period,0,0),length,0);
acu=rtcscale(rtcpjdu(period,0,0),length,0);

leftscl4f1=rtcfloor(rtcscale(scl,0.5,0));
leftscu4f1=rtcceil(rtcscale(scu,0.5,0));

temp=rtcmatminclos(leftscl4f1,f1_buf_r10,5);
while ~rtceq(rtcminconv(leftscl4f1,temp(1)),leftscl4f1)
    f1_buf_r10=f1_buf_r10+1;
    temp=rtcmatminclos(leftscl4f1,f1_buf_r10,5);
end

temp=rtcmatminclos(leftscu4f1,f1_buf_r10,5);
while ~rtceq(rtcminconv(leftscu4f1,temp(1)),leftscu4f1)
    f1_buf_r10=f1_buf_r10+1;
    temp=rtcmatminclos(leftscu4f1,f1_buf_r10,5);
end

temp=rtcmatminclos(scl,f1_buf_r14,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f1_buf_r14=f1_buf_r14+1;
    temp=rtcmatminclos(scl,f1_buf_r14,5);
end

temp=rtcmatminclos(scu,f1_buf_r14,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f1_buf_r14=f1_buf_r14+1;
    temp=rtcmatminclos(scl,f1_buf_r14,5);
end

temp=rtcmatminclos(scl,f1_buf_r15,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f1_buf_r15=f1_buf_r15+1;
    temp=rtcmatminclos(scl,f1_buf_r15,5);
end

temp=rtcmatminclos(scu,f1_buf_r15,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f1_buf_r15=f1_buf_r15+1;
    temp=rtcmatminclos(scl,f1_buf_r15,5);
end

temp=rtcmatminclos(scl,f1_buf_r16,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f1_buf_r16=f1_buf_r16+1;
    temp=rtcmatminclos(scl,f1_buf_r16,5);
end

temp=rtcmatminclos(scu,f1_buf_r16,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f1_buf_r16=f1_buf_r16+1;
    temp=rtcmatminclos(scu,f1_buf_r16,5);
end

disp(['Bufsize Dist for f1: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);
disp(['Bufsize Dist for f4: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);


eqscl4f1=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),leftscl4f1);

while (f1_buf_r10>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r10=f1_buf_r10-1;
    taur10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,5);
    taur14f1=rtcmatminclos(rtcminconv(scl,taur10f1(1)),f1_buf_r14,5);
    taur15f1=rtcmatminclos(rtcminconv(scl,taur14f1(1)),f1_buf_r15,5);
    taur16f1=rtcmatminclos(rtcminconv(scl,taur15f1(1)),f1_buf_r16,5);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taur16f1(1),scl),taur15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taur14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r10==1
    f1_buf_r10=(rtch(acu,eqscl4f1)>Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r10=f1_buf_r10+1;
end
taur10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,5);

while (f1_buf_r14>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r14=f1_buf_r14-1;
    taur14f1=rtcmatminclos(rtcminconv(scl,taur10f1(1)),f1_buf_r14,5);
    taur15f1=rtcmatminclos(rtcminconv(scl,taur14f1(1)),f1_buf_r15,5);
    taur16f1=rtcmatminclos(rtcminconv(scl,taur15f1(1)),f1_buf_r16,5);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taur16f1(1),scl),taur15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taur14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r14==1
    f1_buf_r14=(rtch(acu,eqscl4f1)>Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r14=f1_buf_r14+1;
end
taur14f1=rtcmatminclos(rtcminconv(leftscl4f1,taur10f1(1)),f1_buf_r14,5);

while (f1_buf_r15>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r15=f1_buf_r15-1;
    taur15f1=rtcmatminclos(rtcminconv(scl,taur14f1(1)),f1_buf_r15,5);
    taur16f1=rtcmatminclos(rtcminconv(scl,taur15f1(1)),f1_buf_r16,5);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taur16f1(1),scl),taur15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taur14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r15==1
    f1_buf_r15=(rtch(acu,eqscl4f1)>Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r15=f1_buf_r15+1;
end
taur15f1=rtcmatminclos(rtcminconv(scl,taur14f1(1)),f1_buf_r15,5);

while (f1_buf_r16>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r16=f1_buf_r16-1;
    taur16f1=rtcmatminclos(rtcminconv(scl,taur15f1(1)),f1_buf_r16,5);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taur16f1(1),scl),taur15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taur14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r16==1
    f1_buf_r16=(rtch(acu,eqscl4f1)>Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r16=f1_buf_r16+1;
end

disp(['Optimized Bufsize of f1: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);
disp(['Optimized Bufsize of f4: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);

tauur15f1=rtcmatminclos(scu,f1_buf_r15,5);
partialsclf1=rtcminconv(rtcminconv(taur16f1(1),scl),taur15f1(1));
partialscuf1=rtcminconv(rtcminconv(taur16f1(1),scu),tauur15f1(1));

outacl=rtcmin(rtcminconv(rtcmindeconv(acl,partialscuf1),partialsclf1),partialsclf1);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,partialscuf1),partialsclf1),partialscuf1);

leftscl4f2=rtcmaxconv(rtcminus(scl,outacu),0);
leftscu4f2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl),0),0);

temp=rtcmatminclos(scl,f2_buf_r5,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f2_buf_r5=f2_buf_r5+1;
    temp=rtcmatminclos(scl,f2_buf_r5,5);
end

temp=rtcmatminclos(scl,f2_buf_r9,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f2_buf_r9=f2_buf_r9+1;
    temp=rtcmatminclos(scl,f2_buf_r9,5);
end

temp=rtcmatminclos(scl,f2_buf_r13,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f2_buf_r13=f2_buf_r13+1;
    temp=rtcmatminclos(scl,f2_buf_r13,5);
end

temp=rtcmatminclos(scl,f2_buf_r14,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f2_buf_r14=f2_buf_r14+1;
    temp=rtcmatminclos(scl,f2_buf_r14,5);
end

temp=rtcmatminclos(leftscl4f2,f2_buf_r15,5);
while ~rtceq(rtcminconv(leftscl4f2,temp(1)),leftscl4f2)
    f2_buf_r15=f2_buf_r15+1;
    temp=rtcmatminclos(leftscl4f2,f2_buf_r15,5);
end

temp=rtcmatminclos(scu,f2_buf_r5,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f2_buf_r5=f2_buf_r5+1;
    temp=rtcmatminclos(scu,f2_buf_r5,5);
end

temp=rtcmatminclos(scu,f2_buf_r9,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f2_buf_r9=f2_buf_r9+1;
    temp=rtcmatminclos(scu,f2_buf_r9,5);
end

temp=rtcmatminclos(scu,f2_buf_r13,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f2_buf_r13=f2_buf_r13+1;
    temp=rtcmatminclos(scu,f2_buf_r13,5);
end

temp=rtcmatminclos(scu,f2_buf_r14,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f2_buf_r14=f2_buf_r14+1;
    temp=rtcmatminclos(scl,f2_buf_r14,5);
end

temp=rtcmatminclos(leftscu4f2,f2_buf_r15,5);
while ~rtceq(rtcminconv(leftscu4f2,temp(1)),leftscu4f2)
    f2_buf_r15=f2_buf_r15+1;
    temp=rtcmatminclos(leftscu4f2,f2_buf_r15,5);
end

disp(['Bufsize Dist for f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);

eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscl4f2,scl),scl),scl),scl);
while (f2_buf_r5>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r5=f2_buf_r5-1;
    taur5f2=rtcmatminclos(scl,f2_buf_r5,5);
    taur9f2=rtcmatminclos(rtcminconv(scl,taur5f2(1)),f2_buf_r9,5);
    taur13f2=rtcmatminclos(rtcminconv(scl,taur9f2(1)),f2_buf_r13,5);
    taur14f2=rtcmatminclos(rtcminconv(scl,taur13f2(1)),f2_buf_r14,5);
    taur15f2=rtcmatminclos(rtcminconv(leftscl4f2,taur15f2(1)),f2_buf_r15,5);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur15f2(1),leftscl4f2),taur14f2(1)),scl),taur13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taur9f2(1)),scl),taur5f2(1)),scl);
end
if f2_buf_r5==1
    f2_buf_r5=(rtch(acu,eqscl4f2)>Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r5=f2_buf_r5+1;
end
taur5f2=rtcmatminclos(scl,f2_buf_r5,5);

while (f2_buf_r9>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r9=f2_buf_r9-1;
    taur9f2=rtcmatminclos(rtcminconv(scl,taur5f2(1)),f2_buf_r9,5);
    taur13f2=rtcmatminclos(rtcminconv(scl,taur9f2(1)),f2_buf_r13,5);
    taur14f2=rtcmatminclos(rtcminconv(scl,taur13f2(1)),f2_buf_r14,5);
    taur15f2=rtcmatminclos(rtcminconv(leftscl4f2,taur15f2(1)),f2_buf_r15,5);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur15f2(1),leftscl4f2),taur14f2(1)),scl),taur13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taur9f2(1)),scl),taur5f2(1)),scl);
end
if f2_buf_r9==1
    f2_buf_r9=(rtch(acu,eqscl4f2)>Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r9=f2_buf_r9+1;
end
taur9f2=rtcmatminclos(scl,f2_buf_r9,5);

while (f2_buf_r13>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r13=f2_buf_r13-1;
    taur13f2=rtcmatminclos(rtcminconv(scl,taur9f2(1)),f2_buf_r13,5);
    taur14f2=rtcmatminclos(rtcminconv(scl,taur13f2(1)),f2_buf_r14,5);
    taur15f2=rtcmatminclos(rtcminconv(leftscl4f2,taur15f2(1)),f2_buf_r15,5);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur15f2(1),leftscl4f2),taur14f2(1)),scl),taur13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taur9f2(1)),scl),taur5f2(1)),scl);
end
if f2_buf_r13==1
    f2_buf_r13=(rtch(acu,eqscl4f2)>Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r13=f2_buf_r13+1;
end
taur13f2=rtcmatminclos(scl,f2_buf_r13,5);

while (f2_buf_r14>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r14=f2_buf_r14-1;
    taur14f2=rtcmatminclos(rtcminconv(scl,taur13f2(1)),f2_buf_r14,5);
    taur15f2=rtcmatminclos(rtcminconv(leftscl4f2,taur15f2(1)),f2_buf_r15,5);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur15f2(1),leftscl4f2),taur14f2(1)),scl),taur13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taur9f2(1)),scl),taur5f2(1)),scl);
end
if f2_buf_r14==1
    f2_buf_r14=(rtch(acu,eqscl4f2)>Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r14=f2_buf_r14+1;
end
taur14f2=rtcmatminclos(scl,f2_buf_r14,5);

while (f2_buf_r15>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r15=f2_buf_r15-1;
    taur15f2=rtcmatminclos(rtcminconv(leftscl4f2,taur15f2(1)),f2_buf_r15,5);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur15f2(1),leftscl4f2),taur14f2(1)),scl),taur13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taur9f2(1)),scl),taur5f2(1)),scl);
end
if f2_buf_r15==1
    f2_buf_r15=(rtch(acu,eqscl4f2)>Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r15=f2_buf_r15+1;
end

disp(['Optimized Bufsize of f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);

partialscu4f2=rtcminconv(leftscu4f2,scu);
partialscl4f2=rtcminconv(leftscl4f2,scl);
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f2),partialscl4f2),partialscu4f2);
outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f2),partialscl4f2),partialscl4f2);

concscu=rtcminconv(scu,scu);
concscl=rtcminconv(scl,scl);

leftscl4f3=rtcmaxconv(rtcminus(concscl,outacu4f2),0);
leftscu4f3=rtcmax(rtcmaxdeconv(rtcminus(concscu,outacl4f2),0),0);

temp=rtcmatminclos(scl,f3_buf_r1,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f3_buf_r1=f3_buf_r1+1;
    temp=rtcmatminclos(scl,f3_buf_r1,5);
end

temp=rtcmatminclos(scl,f3_buf_r5,5);
while ~rtceq(rtcminconv(scl,temp(1)),scl)
    f3_buf_r5=f3_buf_r5+1;
    temp=rtcmatminclos(scl,f3_buf_r5,5);
end

temp=rtcmatminclos(leftscl4f3,f3_buf_r139,5);
while ~rtceq(rtcminconv(leftscl4f3,temp(1)),leftscl4f3)
    f3_buf_r139=f3_buf_r139+1;
    temp=rtcmatminclos(leftscl4f3,f3_buf_r139,5);
end

temp=rtcmatminclos(scu,f3_buf_r1,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f3_buf_r1=f3_buf_r1+1;
    temp=rtcmatminclos(scu,f3_buf_r1,5);
end

temp=rtcmatminclos(scu,f3_buf_r5,5);
while ~rtceq(rtcminconv(scu,temp(1)),scu)
    f3_buf_r5=f3_buf_r5+1;
    temp=rtcmatminclos(scu,f3_buf_r5,5);
end

temp=rtcmatminclos(leftscu4f3,f3_buf_r139,5);
while ~rtceq(rtcminconv(leftscu4f3,temp(1)),leftscu4f3)
    f3_buf_r139=f3_buf_r139+1;
    temp=rtcmatminclos(leftscu4f3,f3_buf_r139,5);
end

disp(['Bufsize Dist for f3: ',num2str(f3_buf_r139),' , ',num2str(f2_buf_r5),' , ',num2str(f3_buf_r1)]);

eqscl4f3=rtcminconv(rtcminconv(rtcminconv(leftscu4f3,scl),scl),scl);

while (f3_buf_r1>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r1=f3_buf_r1-1;
    taur1f3=rtcmatminclos(scl,f3_buf_r1,5);
    taur5f3=rtcmatminclos(rtcminconv(scl,taur1f3(1)),f3_buf_r5,5);
    taur139f3=rtcmatminclos(rtcminconv(leftscl4f3,taur139f3(1)),f1_buf_r139,5);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur139f3(1),leftscl4f3),taur5f3(1)),scl),taur1f3),scl);
end
if f3_buf_r1==1
    f3_buf_r1=(rtch(acu,eqscl4f3)>Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r1=f3_buf_r1+1;
end
taur1f3=rtcmatminclos(scl,f3_buf_r1,5);

while (f3_buf_r5>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r5=f3_buf_r5-1;
    taur5f3=rtcmatminclos(rtcminconv(scl,taur1f3(1)),f3_buf_r5,5);
    taur139f3=rtcmatminclos(rtcminconv(leftscl4f3,taur139f3(1)),f1_buf_r139,5);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur139f3(1),leftscl4f3),taur5f3(1)),scl),taur1f3),scl);
end
if f3_buf_r5==1
    f3_buf_r5=(rtch(acu,eqscl4f3)>Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r5=f3_buf_r5+1;
end
taur5f3=rtcmatminclos(scl,f3_buf_r5,5);

while (f3_buf_r139>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r139=f3_buf_r139-1;
    taur139f3=rtcmatminclos(rtcminconv(leftscl4f3,taur139f3(1)),f1_buf_r139,5);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taur139f3(1),leftscl4f3),taur5f3(1)),scl),taur1f3),scl);
end
if f3_buf_r139==1
    f3_buf_r139=(rtch(acu,eqscl4f3)>Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r139=f3_buf_r139+1;
end

disp(['Optimized Bufsize of f3: ',num2str(f3_buf_r139),' , ',num2str(f2_buf_r5),' , ',num2str(f3_buf_r1)]);