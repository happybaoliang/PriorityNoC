times=5;

f1_buf_r10=0;
f1_buf_r14=0;
f1_buf_r15=0;
f1_buf_r16=0;

f2_buf_r15=0;
f2_buf_r14=0;
f2_buf_r13=0;
f2_buf_r9=0;
f2_buf_r5=0;

f3_buf_r1=0;
f3_buf_r5=0;
f3_buf_r9=0;
f3_buf_r13=0;

f4_buf_r8=0;
f4_buf_r7=0;
f4_buf_r6=0;
f4_buf_r10=0;


length=1;
period=length*6;
Deadline=[10 10 10 10];

scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

acl=rtcscale(rtcpjdl(period,0,0),length,0);
acu=rtcscale(rtcpjdu(period,0,0),length,0);

taulr10f4=rtcmatminclos(scl,f4_buf_r10,times);
while ~rtceq(rtcminconv(scl,taulr10f4(1)),scl)
    f4_buf_r10=f4_buf_r10+1;
    taulr10f4=rtcmatminclos(scl,f4_buf_r10,times);
end
tauur10f4=rtcmatminclos(scu,f4_buf_r10,times);
while ~rtceq(rtcminconv(scu,tauur10f4(1)),scu)
    f4_buf_r10=f4_buf_r10+1;
    tauur10f4=rtcmatminclos(scu,f4_buf_r10,times);
end
taulr6f4=rtcmatminclos(scl,f4_buf_r6,times);
while ~rtceq(rtcminconv(scl,taulr6f4(1)),scl)
    f4_buf_r6=f4_buf_r6+1;
    taulr6f4=rtcmatminclos(scl,f4_buf_r6,times);
end
tauur6f4=rtcmatminclos(scu,f4_buf_r6,times);
while ~rtceq(rtcminconv(scu,tauur6f4(1)),scu)
    f4_buf_r6=f4_buf_r6+1;
    tauur6f4=rtcmatminclos(scl,f4_buf_r6,times);
end
taulr7f4=rtcmatminclos(scl,f4_buf_r7,times);
while ~rtceq(rtcminconv(scl,taulr7f4(1)),scl)
    f4_buf_r7=f4_buf_r7+1;
    taulr7f4=rtcmatminclos(scl,f4_buf_r7,times);
end
tauur7f4=rtcmatminclos(scu,f4_buf_r7,times);
while ~rtceq(rtcminconv(scu,tauur7f4(1)),scu)
    f4_buf_r7=f4_buf_r7+1;
    tauur7f4=rtcmatminclos(scl,f4_buf_r7,times);
end
taulr8f4=rtcmatminclos(scl,f4_buf_r8,times);
while ~rtceq(rtcminconv(scl,taulr8f4(1)),scl)
    f4_buf_r8=f4_buf_r8+1;
    taulr8f4=rtcmatminclos(scl,f4_buf_r8,times);
end
tauur8f4=rtcmatminclos(scu,f4_buf_r8,times);
while ~rtceq(rtcminconv(scu,tauur8f4(1)),scu)
    f4_buf_r8=f4_buf_r8+1;
    tauur8f4=rtcmatminclos(scu,f4_buf_r8,times);
end
disp(['Buffer size Dist for f4: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);


eqscl4f4=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),scl);
while (f4_buf_r10>1) && (rtch(acu,eqscl4f4)<Deadline(4))
    f4_buf_r10=f4_buf_r10-1;
    taulr10f4=rtcmatminclos(scl,f4_buf_r10,times);
    taulr6f4=rtcmatminclos(rtcminconv(scl,taulr10f4(1)),f4_buf_r6,times);
    taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
    taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
end
if f4_buf_r10==1
    f4_buf_r10=(rtch(acu,eqscl4f4)<Deadline(4))+(rtch(acu,eqscl4f4)>Deadline(4))*2;
else
    f4_buf_r10=f4_buf_r10+1;
end
taulr10f4=rtcmatminclos(scl,f4_buf_r10,times);
taulr6f4=rtcmatminclos(rtcminconv(scl,taulr10f4(1)),f4_buf_r6,times);
taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
tauur10f4=rtcmatminclos(scu,f4_buf_r10,times);
tauur6f4=rtcmatminclos(rtcminconv(scu,tauur10f4(1)),f4_buf_r6,times);
tauur7f4=rtcmatminclos(rtcminconv(scu,tauur14f4(1)),f4_buf_r7,times);
tauur8f4=rtcmatminclos(rtcminconv(scu,tauur15f4(1)),f4_buf_r8,times);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(tauur8f4(1),scu),tauur6f4(1)),scu);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscu4f4,tauur7f4(1)),scu),tauur8f4(1)),scu);
while (f4_buf_r6>1) && (rtch(acu,eqscl4f4)<Deadline(4))
    f4_buf_r6=f4_buf_r6-1;
    taulr6f4=rtcmatminclos(rtcminconv(scl,taulr10f4(1)),f4_buf_r6,times);
    taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
    taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
end
if f4_buf_r6==1
    f4_buf_r6=(rtch(acu,eqscl4f4)<Deadline(4))+(rtch(acu,eqscl4f4)>Deadline(4))*2;
else
    f4_buf_r6=f4_buf_r6+1;
end
taulr6f4=rtcmatminclos(rtcminconv(scl,taulr10f4(1)),f4_buf_r6,times);
taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
tauur6f4=rtcmatminclos(rtcminconv(scu,tauur10f4(1)),f4_buf_r6,times);
tauur7f4=rtcmatminclos(rtcminconv(scu,tauur14f4(1)),f4_buf_r7,times);
tauur8f4=rtcmatminclos(rtcminconv(scu,tauur15f4(1)),f4_buf_r8,times);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(tauur8f4(1),scu),tauur6f4(1)),scu);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscu4f4,tauur7f4(1)),scu),tauur8f4(1)),scu);
while (f4_buf_r7>1) && (rtch(acu,eqscl4f4)<Deadline(4))
    f4_buf_r7=f4_buf_r7-1;
    taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
    taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
end
if f4_buf_r7==1
    f4_buf_r7=(rtch(acu,eqscl4f4)<Deadline(4))+(rtch(acu,eqscl4f4)>Deadline(4))*2;
else
    f4_buf_r7=f4_buf_r7+1;
end
taulr7f4=rtcmatminclos(rtcminconv(scl,taulr14f4(1)),f4_buf_r7,times);
taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
tauur7f4=rtcmatminclos(rtcminconv(scu,tauur14f4(1)),f4_buf_r7,times);
tauur8f4=rtcmatminclos(rtcminconv(scu,tauur15f4(1)),f4_buf_r8,times);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(tauur8f4(1),scu),tauur6f4(1)),scu);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscu4f4,tauur7f4(1)),scu),tauur8f4(1)),scu);
while (f4_buf_r8>1) && (rtch(acu,eqscl4f4)<Deadline(4))
    f4_buf_r8=f4_buf_r8-1;
    taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
    eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
end
if f4_buf_r8==1
    f4_buf_r8=(rtch(acu,eqscl4f4)<Deadline(4))+(rtch(acu,eqscl4f4)>Deadline(4))*2;
else
    f4_buf_r8=f4_buf_r8+1;
end
taulr8f4=rtcmatminclos(rtcminconv(scl,taulr15f4(1)),f4_buf_r8,times);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(taulr8f4(1),scl),taulr6f4(1)),scl);
eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f4,taulr7f4(1)),scl),taulr8f4(1)),scl);
tauur8f4=rtcmatminclos(rtcminconv(scu,tauur15f4(1)),f4_buf_r8,times);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(tauur8f4(1),scu),tauur6f4(1)),scu);
eqscu4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscu4f4,tauur7f4(1)),scu),tauur8f4(1)),scu);
disp(['Optimized Bufsize of f4: ',num2str(f4_buf_r10),' , ',num2str(f4_buf_r6),' , ',num2str(f4_buf_r7),' , ',num2str(f4_buf_r8)]);

partialscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr8f4,scl),taulr7f4),scl),taulr6f4),scl),taulr8f4);
partialscu4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(tauur8f4,scu),tauur7f4),scu),tauur6f4),scu),tauur8f4);
outputacl4f4=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f4),partialscl4f4),partialscl4f4);
outputacu4f4=rtcmin(rtcmindeconv(rtcminconv(acl,partialscu4f4),partialscl4f4),partialscl4f4);
leftscl4f1=rtcmaxconv(rtcminus(scl,outputacu4f4),0);
leftscu4f1=rtcmax(rtcmaxdeconv(rtcminus(scu,outputacl4f4),0),0);

taulr10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,times);
while ~rtceq(rtcminconv(leftscl4f1,taulr10f1(1)),leftscl4f1)
    f1_buf_r10=f1_buf_r10+1;
    taulr10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,times);
end
tauur10f1=rtcmatminclos(leftscu4f1,f1_buf_r10,times);
while ~rtceq(rtcminconv(leftscu4f1,tauur10f1(1)),leftscu4f1)
    f1_buf_r10=f1_buf_r10+1;
    tauur10f1=rtcmatminclos(leftscu4f1,f1_buf_r10,times);
end
taulr14f1=rtcmatminclos(scl,f1_buf_r14,times);
while ~rtceq(rtcminconv(scl,taulr14f1(1)),scl)
    f1_buf_r14=f1_buf_r14+1;
    taulr14f1=rtcmatminclos(scl,f1_buf_r14,times);
end
tauur14f1=rtcmatminclos(scu,f1_buf_r14,times);
while ~rtceq(rtcminconv(scu,tauur14f1(1)),scu)
    f1_buf_r14=f1_buf_r14+1;
    tauur14f1=rtcmatminclos(scl,f1_buf_r14,times);
end
taulr15f1=rtcmatminclos(scl,f1_buf_r15,times);
while ~rtceq(rtcminconv(scl,taulr15f1(1)),scl)
    f1_buf_r15=f1_buf_r15+1;
    taulr15f1=rtcmatminclos(scl,f1_buf_r15,times);
end
tauur15f1=rtcmatminclos(scu,f1_buf_r15,times);
while ~rtceq(rtcminconv(scu,tauur15f1(1)),scu)
    f1_buf_r15=f1_buf_r15+1;
    tauur15f1=rtcmatminclos(scl,f1_buf_r15,times);
end
taulr16f1=rtcmatminclos(scl,f1_buf_r16,times);
while ~rtceq(rtcminconv(scl,taulr16f1(1)),scl)
    f1_buf_r16=f1_buf_r16+1;
    taulr16f1=rtcmatminclos(scl,f1_buf_r16,times);
end
tauur16f1=rtcmatminclos(scu,f1_buf_r16,times);
while ~rtceq(rtcminconv(scu,tauur16f1(1)),scu)
    f1_buf_r16=f1_buf_r16+1;
    tauur16f1=rtcmatminclos(scu,f1_buf_r16,times);
end
disp(['Buffer size Dist for f1: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);


eqscl4f1=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),leftscl4f1);
while (f1_buf_r10>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r10=f1_buf_r10-1;
    taulr10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,times);
    taulr14f1=rtcmatminclos(rtcminconv(scl,taulr10f1(1)),f1_buf_r14,times);
    taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
    taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taulr10f1(1)),leftscl4f1);
end
if f1_buf_r10==1
    f1_buf_r10=(rtch(acu,eqscl4f1)<Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r10=f1_buf_r10+1;
end
taulr10f1=rtcmatminclos(leftscl4f1,f1_buf_r10,times);
tauur10f1=rtcmatminclos(leftscu4f1,f1_buf_r10,times);
taulr14f1=rtcmatminclos(rtcminconv(scl,taulr10f1(1)),f1_buf_r14,times);
taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taulr10f1(1)),leftscl4f1);
while (f1_buf_r14>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r14=f1_buf_r14-1;
    taulr14f1=rtcmatminclos(rtcminconv(scl,taur10f1(1)),f1_buf_r14,times);
    taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
    taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r14==1
    f1_buf_r14=(rtch(acu,eqscl4f1)<Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r14=f1_buf_r14+1;
end
taulr14f1=rtcmatminclos(rtcminconv(leftscl4f1,taulr10f1(1)),f1_buf_r14,times);
tauur14f1=rtcmatminclos(rtcminconv(leftscu4f1,tauur10f1(1)),f1_buf_r14,times);
taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taulr10f1(1)),leftscl4f1);    
while (f1_buf_r15>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r15=f1_buf_r15-1;
    taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
    taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r15==1
    f1_buf_r15=(rtch(acu,eqscl4f1)<Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r15=f1_buf_r15+1;
end
taulr15f1=rtcmatminclos(rtcminconv(scl,taulr14f1(1)),f1_buf_r15,times);
tauur15f1=rtcmatminclos(rtcminconv(scu,tauur14f1(1)),f1_buf_r15,times);
taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taulr10f1(1)),leftscl4f1);
while (f1_buf_r16>1) && (rtch(acu,eqscl4f1)<Deadline(1))
    f1_buf_r16=f1_buf_r16-1;
    taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1)),scl);
    eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f1,taulr14f1(1)),scl),taur10f1(1)),leftscl4f1);
end
if f1_buf_r16==1
    f1_buf_r16=(rtch(acu,eqscl4f1)<Deadline(1))+(rtch(acu,eqscl4f1)>Deadline(1))*2;
else
    f1_buf_r16=f1_buf_r16+1;
end
taulr16f1=rtcmatminclos(rtcminconv(scl,taulr15f1(1)),f1_buf_r16,times);
tauur16f1=rtcmatminclos(rtcminconv(scu,tauur15f1(1)),f1_buf_r16,times);
disp(['Optimized Bufsize of f1: ',num2str(f1_buf_r10),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r16)]);


partialsclf1=rtcminconv(rtcminconv(taulr16f1(1),scl),taulr15f1(1));
partialscuf1=rtcminconv(rtcminconv(tauur16f1(1),scu),tauur15f1(1));
outacl=rtcmin(rtcminconv(rtcmindeconv(acl,partialscuf1),partialsclf1),partialsclf1);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,partialscuf1),partialsclf1),partialscuf1);
leftscl4f2=rtcmaxconv(rtcminus(scl,outacu),0);
leftscu4f2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl),0),0);
taulr5f2=rtcmatminclos(scl,f2_buf_r5,times);
while ~rtceq(rtcminconv(scl,taulr5f2(1)),scl)
    f2_buf_r5=f2_buf_r5+1;
    taulr5f2=rtcmatminclos(scl,f2_buf_r5,times);
end
tauur5f2=rtcmatminclos(scu,f2_buf_r5,times);
while ~rtceq(rtcminconv(scu,tauur5f2(1)),scu)
    f2_buf_r5=f2_buf_r5+1;
    tauur5f2=rtcmatminclos(scu,f2_buf_r5,times);
end
taulr9f2=rtcmatminclos(scl,f2_buf_r9,times);
while ~rtceq(rtcminconv(scl,taulr9f2(1)),scl)
    f2_buf_r9=f2_buf_r9+1;
    taulr9f2=rtcmatminclos(scl,f2_buf_r9,times);
end
tauur9f2=rtcmatminclos(scu,f2_buf_r9,times);
while ~rtceq(rtcminconv(scu,tauur9f2(1)),scu)
    f2_buf_r9=f2_buf_r9+1;
    tauur9f2=rtcmatminclos(scu,f2_buf_r9,times);
end
taulr13f2=rtcmatminclos(scl,f2_buf_r13,times);
while ~rtceq(rtcminconv(scl,taulr13f2(1)),scl)
    f2_buf_r13=f2_buf_r13+1;
    taulr13f2=rtcmatminclos(scl,f2_buf_r13,times);
end
tauur13f2=rtcmatminclos(scu,f2_buf_r13,times);
while ~rtceq(rtcminconv(scu,tauur13f2(1)),scu)
    f2_buf_r13=f2_buf_r13+1;
    tauur13f2=rtcmatminclos(scu,f2_buf_r13,times);
end
taulr14f2=rtcmatminclos(scl,f2_buf_r14,times);
while ~rtceq(rtcminconv(scl,taulr14f2(1)),scl)
    f2_buf_r14=f2_buf_r14+1;
    taulr14f2=rtcmatminclos(scl,f2_buf_r14,times);
end
tauur14f2=rtcmatminclos(scu,f2_buf_r14,times);
while ~rtceq(rtcminconv(scu,tauur14f2(1)),scu)
    f2_buf_r14=f2_buf_r14+1;
    tauur14f2=rtcmatminclos(scl,f2_buf_r14,times);
end
taulr15f2=rtcmatminclos(leftscl4f2,f2_buf_r15,times);
while ~rtceq(rtcminconv(leftscl4f2,taulr15f2(1)),leftscl4f2)
    f2_buf_r15=f2_buf_r15+1;
    taulr15f2=rtcmatminclos(leftscl4f2,f2_buf_r15,times);
end
tauur15f2=rtcmatminclos(leftscu4f2,f2_buf_r15,times);
while ~rtceq(rtcminconv(leftscu4f2,tauur15f2(1)),leftscu4f2)
    f2_buf_r15=f2_buf_r15+1;
    tauur15f2=rtcmatminclos(leftscu4f2,f2_buf_r15,times);
end
disp(['Buffer size Dist for f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);

eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscl4f2,scl),scl),scl),scl);
while (f2_buf_r5>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r5=f2_buf_r5-1;
    taulr5f2=rtcmatminclos(scl,f2_buf_r5,times);
    taulr9f2=rtcmatminclos(rtcminconv(scl,taulr5f2(1)),f2_buf_r9,times);
    taulr13f2=rtcmatminclos(rtcminconv(scl,taulr9f2(1)),f2_buf_r13,times);
    taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
    taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
end
if f2_buf_r5==1
    f2_buf_r5=(rtch(acu,eqscl4f2)<Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r5=f2_buf_r5+1;
end
taulr5f2=rtcmatminclos(scl,f2_buf_r5,times);
tauur5f2=rtcmatminclos(scu,f2_buf_r5,times);
taulr9f2=rtcmatminclos(rtcminconv(scl,taulr5f2(1)),f2_buf_r9,times);
taulr13f2=rtcmatminclos(rtcminconv(scl,taulr9f2(1)),f2_buf_r13,times);
taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
while (f2_buf_r9>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r9=f2_buf_r9-1;
    taulr9f2=rtcmatminclos(rtcminconv(scl,taulr5f2(1)),f2_buf_r9,times);
    taulr13f2=rtcmatminclos(rtcminconv(scl,taulr9f2(1)),f2_buf_r13,times);
    taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
    taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
end
if f2_buf_r9==1
    f2_buf_r9=(rtch(acu,eqscl4f2)<Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r9=f2_buf_r9+1;
end
taulr9f2=rtcmatminclos(scl,f2_buf_r9,times);
tauur9f2=rtcmatminclos(scu,f2_buf_r9,times);
taulr13f2=rtcmatminclos(rtcminconv(scl,taulr9f2(1)),f2_buf_r13,times);
taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
while (f2_buf_r13>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r13=f2_buf_r13-1;
    taulr13f2=rtcmatminclos(rtcminconv(scl,taulr9f2(1)),f2_buf_r13,times);
    taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
    taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
end
if f2_buf_r13==1
    f2_buf_r13=(rtch(acu,eqscl4f2)<Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r13=f2_buf_r13+1;
end
taulr13f2=rtcmatminclos(scl,f2_buf_r13,times);
tauur13f2=rtcmatminclos(scu,f2_buf_r13,times);
taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
while (f2_buf_r14>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r14=f2_buf_r14-1;
    taulr14f2=rtcmatminclos(rtcminconv(scl,taulr13f2(1)),f2_buf_r14,times);
    taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
end
if f2_buf_r14==1
    f2_buf_r14=(rtch(acu,eqscl4f2)<Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r14=f2_buf_r14+1;
end
taulr14f2=rtcmatminclos(scl,f2_buf_r14,times);
tauur14f2=rtcmatminclos(scu,f2_buf_r14,times);
taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
while (f2_buf_r15>1) && (rtch(acu,eqscl4f2)<Deadline(2))
    f2_buf_r15=f2_buf_r15-1;
    taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
    eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);
end
if f2_buf_r15==1
    f2_buf_r15=(rtch(acu,eqscl4f2)<Deadline(2))+(rtch(acu,eqscl4f2)>Deadline(2))*2;
else
    f2_buf_r15=f2_buf_r15+1;
end
tauur15f2=rtcmatminclos(rtcminconv(leftscu4f2,tauur14f2(1)),f2_buf_r15,times);
taulr15f2=rtcmatminclos(rtcminconv(leftscl4f2,taulr14f2(1)),f2_buf_r15,times);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl),taulr13f2(1));
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl4f2,scl),taulr9f2(1)),scl),taulr5f2(1)),scl);    
disp(['Optimized Bufsize of f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);

taulr1f3=rtcmatminclos(scl,f3_buf_r1,times);
while ~rtceq(rtcminconv(scl,taulr1f3(1)),scl)
    f3_buf_r1=f3_buf_r1+1;
    taulr1f3=rtcmatminclos(scl,f3_buf_r1,times);
end
tauur1f3=rtcmatminclos(scu,f3_buf_r1,times);
while ~rtceq(rtcminconv(scu,tauur1f3(1)),scu)
    f3_buf_r1=f3_buf_r1+1;
    tauur1f3=rtcmatminclos(scu,f3_buf_r1,times);
end
taulr5f3=rtcmatminclos(scl,f3_buf_r5,times);
while ~rtceq(rtcminconv(scl,taulr5f3(1)),scl)
    f3_buf_r5=f3_buf_r5+1;
    taulr5f3=rtcmatminclos(scl,f3_buf_r5,times);
end
tauur5f3=rtcmatminclos(scu,f3_buf_r5,times);
while ~rtceq(rtcminconv(scu,tauur5f3(1)),scu)
    f3_buf_r5=f3_buf_r5+1;
    tauur5f3=rtcmatminclos(scu,f3_buf_r5,times);
end
partialscu4f2=rtcminconv(rtcminconv(rtcminconv(tauur15f2(1),leftscu4f2),tauur14f2(1)),scu);
partialscl4f2=rtcminconv(rtcminconv(rtcminconv(taulr15f2(1),leftscl4f2),taulr14f2(1)),scl);
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f2),partialscl4f2),partialscu4f2);
outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f2),partialscl4f2),partialscl4f2);
leftscl134f3=rtcmaxconv(rtcminus(scl,outacu4f2),0);
leftscu134f3=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f2),0),0);
taulr13f3=rtcmatminclos(leftscl134f3,f3_buf_r13,times);
while ~rtceq(rtcminconv(leftscl134f3,taulr13f3(1)),leftscl134f3)
    f3_buf_r13=f3_buf_r13+1;
    taulr13f3=rtcmatminclos(leftscl134f3,f3_buf_r13,times);
end
tauur13f3=rtcmatminclos(leftscu134f3,f3_buf_r13,times);
taulr13f3=rtcmatminclos(leftscl134f3,f3_buf_r13,times);
while ~rtceq(rtcminconv(leftscu134f3,tauur13f3(1)),leftscu134f3)
    f3_buf_r13=f3_buf_r13+1;
    tauur13f3=rtcmatminclos(leftscu134f3,f3_buf_r13,times);
end
partialscu4f2=rtcminconv(rtcminconv(partialscu4f2,scu),tauur13f3(1));
partialscl4f2=rtcminconv(rtcminconv(partialscl4f2,scl),taulr13f3(1));
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f2),partialscl4f2),partialscu4f2);
outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f2),partialscl4f2),partialscl4f2);
leftscl94f3=rtcmaxconv(rtcminus(scl,outacu4f2),0);
leftscu94f3=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f2),0),0);
taulr9f3=rtcmatminclos(leftscl94f3,f3_buf_r9,times);
while ~rtceq(rtcminconv(leftscl94f3,taulr9f3(1)),leftscl94f3)
    f3_buf_r9=f3_buf_r9+1;
    taulr9f3=rtcmatminclos(leftscl94f3,f3_buf_r9,times);
end
tauur9f3=rtcmatminclos(leftscu94f3,f3_buf_r9,times);
while ~rtceq(rtcminconv(leftscu94f3,tauur9f3(1)),leftscu94f3)
    f3_buf_r9=f3_buf_r9+1;
    tauur9f3=rtcmatminclos(leftscu94f3,f3_buf_r9,times);
end
disp(['Buffer size Dist for f3: ',num2str(f3_buf_r13),' , ',num2str(f3_buf_r9),' , ',num2str(f2_buf_r5),' , ',num2str(f3_buf_r1)]);

eqscl4f3=rtcminconv(rtcminconv(rtcminconv(leftscl134f3,leftscl94f3),scl),scl);
while (f3_buf_r1>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r1=f3_buf_r1-1;
    taulr1f3=rtcmatminclos(scl,f3_buf_r1,times);
    taulr5f3=rtcmatminclos(rtcminconv(scl,taulr1f3(1)),f3_buf_r5,times);
    taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
    taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
end
if f3_buf_r1==1
    f3_buf_r1=(rtch(acu,eqscl4f3)<Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r1=f3_buf_r1+1;
end
taulr1f3=rtcmatminclos(scl,f3_buf_r1,times);
tauur1f3=rtcmatminclos(scu,f3_buf_r1,times);
taulr5f3=rtcmatminclos(rtcminconv(scl,taulr1f3(1)),f3_buf_r5,times);
taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
while (f3_buf_r5>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r5=f3_buf_r5-1;
    taulr5f3=rtcmatminclos(rtcminconv(scl,taulr1f3(1)),f3_buf_r5,times);
    taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
    taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
end
if f3_buf_r5==1
    f3_buf_r5=(rtch(acu,eqscl4f3)<Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r5=f3_buf_r5+1;
end
taulr5f3=rtcmatminclos(scl,f3_buf_r5,times);
tauur5f3=rtcmatminclos(scu,f3_buf_r5,times);
taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
while (f3_buf_r9>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r9=f3_buf_r9-1;
    taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
    taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
end
if f3_buf_r9==1
    f3_buf_r9=(rtch(acu,eqscl4f3)<Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r9=f3_buf_r9+1;
end
taulr9f3=rtcmatminclos(rtcminconv(leftscl94f3,taulr5f3(1)),f3_buf_r9,times);
taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
while (f3_buf_r13>1) && (rtch(acu,eqscl4f3)<Deadline(3))
    f3_buf_r13=f3_buf_r13-1;
    taulr13f3=rtcmatminclos(rtcminconv(leftscl134f3,taulr9f3(1)),f3_buf_r13,times);
    eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(taulr13f3(1),leftscl134f3),taulr9f3(1)),leftscl94f3),taulr5f3(1)),scl),taulr1f3(1)),scl);
end
if f3_buf_r13==1
    f3_buf_r13=(rtch(acu,eqscl4f3)<Deadline(3))+(rtch(acu,eqscl4f3)>Deadline(3))*2;
else
    f3_buf_r13=f3_buf_r13+1;
end
disp(['Optimized Bufsize of f3: ',num2str(f3_buf_r13),' , ',num2str(f3_buf_r9),' , ',num2str(f3_buf_r5),' , ',num2str(f3_buf_r1)]);