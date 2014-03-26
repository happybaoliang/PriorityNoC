function rtcvslla()
length=4;
period=15;
disp('RTC: ');
    RTC(length,period);
disp('LLA: ');
    LLA(length,period);
end

function RTC(length,period)

scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

acl=rtcscale(rtcpjdl(period,0,0),length,0);
acu=rtcscale(rtcpjdu(period,0,0),length,0);

partialscu4f4=rtcminconv(rtcminconv(scu,scu),scu);
partialscl4f4=rtcminconv(rtcminconv(scl,scl),scl);

eqscl4f4=rtcminconv(partialscl4f4,scl);

outacu4f4=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f4),partialscl4f4),partialscu4f4);
%outacl4f4=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f4),partialscl4f4),partialscl4f4);

leftscl4f1=rtcmaxconv(rtcminus(scl,outacu4f4),0);
%leftscu4f1=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f4),0),0);

%eqscu4f1=rtcminconv(rtcminconv(rtcminconv(scu,scu),scu),leftscu4f1);
eqscl4f1=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),leftscl4f1);

outacl4f1=rtcmin(rtcminconv(rtcmindeconv(acl,scu),scl),scl);
outacu4f1=rtcmin(rtcmindeconv(rtcminconv(acu,scu),scl),scu);

leftscl4f2=rtcmaxconv(rtcminus(scl,outacu4f1),0);
leftscu4f2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f1),0),0);

%eqscu4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscu4f2,scu),scu),scu),scu);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscl4f2,scl),scl),scl),scl);

partialscu4f2=rtcminconv(leftscu4f2,scu);
partialscl4f2=rtcminconv(leftscl4f2,scl);
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f2),partialscl4f2),partialscu4f2);
%outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f2),partialscl4f2),partialscl4f2);

%concscu=rtcminconv(scu,scu);
concscl=rtcminconv(scl,scl);

leftscl4f3=rtcmaxconv(rtcminus(concscl,outacu4f2),0);
%leftscu4f3=rtcmax(rtcmaxdeconv(rtcminus(concscu,outacl4f2),0),0);

eqscl4f3=rtcminconv(rtcminconv(leftscl4f3,scl),scl);

disp([rtch(acu,eqscl4f1),rtch(acu,eqscl4f2),rtch(acu,eqscl4f3),rtch(acu,eqscl4f4)])
end

function LLA(length,period)
J=[0 0 0 0];
L=[length length length length];
T=[period period period period];

%f4
f4_delay_r8=L(4);
f4_delay_r7=f4_delay_r8;
f4_delay_r6=f4_delay_r7;
f4_delay_r10=f4_delay_r6;
%f1
f1_delay_r16=L(1);
f1_delay_r15=f1_delay_r16;
f1_delay_r14=f1_delay_r15;
f1_delay_r10=L(1);
indirect_jitter_to_f1=0;
newvalue=f1_delay_r14+L(4)*ceil((f1_delay_r10+J(4)+indirect_jitter_to_f1)/T(4));
while(f1_delay_r10~=newvalue)
    f1_delay_r10=newvalue;
    newvalue=f1_delay_r14+L(4)*ceil((f1_delay_r10+J(4)+indirect_jitter_to_f1)/T(4));
end
%f2
f2_delay_r15=L(2);
indirect_jitter_to_f2=f1_delay_r10+J(1)+(4-1)-4;
newvalue=L(2)+ceil((f2_delay_r15+J(1)+indirect_jitter_to_f2)/T(1))*L(1);
while (f2_delay_r15~=newvalue)
    f2_delay_r15=newvalue;
    newvalue=L(2)+ceil((f2_delay_r15+J(1)+indirect_jitter_to_f2)/T(1))*L(1);
end
f2_delay_r14=f2_delay_r15;
f2_delay_r13=f2_delay_r14;
f2_delay_r9=f2_delay_r13;
f2_delay_r5=f2_delay_r9;
%f3
f3_delay_r13=L(3);
indirect_jitter_to_f3=f2_delay_r5+J(2)+(5-1)-5;
newvalue=L(3)+ceil((f3_delay_r13+J(2)+indirect_jitter_to_f3)/T(2))*L(2);
while (f3_delay_r13~=newvalue)
    f3_delay_r13=newvalue;
    newvalue=L(3)+ceil((f3_delay_r13+J(2)+indirect_jitter_to_f3)/T(2))*L(2);
end
f3_delay_r9=L(3);
newvalue=f3_delay_r13+ceil((f3_delay_r9+J(2)+indirect_jitter_to_f3)/T(2))*L(2)-ceil((f3_delay_r13+J(2)+indirect_jitter_to_f3)/T(2))*L(2);
while (f3_delay_r9~=newvalue)
    f3_delay_r9=newvalue;
    newvalue=f3_delay_r13+ceil((f3_delay_r9+J(2)+indirect_jitter_to_f3)/T(2))*L(2)-ceil((f3_delay_r13+J(2)+indirect_jitter_to_f3)/T(2))*L(2);
end
f3_delay_r5=f3_delay_r9;
f3_delay_r1=f3_delay_r5;
disp(['     ',num2str(f1_delay_r10+J(1)+(4-1)),'     ',num2str(f2_delay_r5+J(2)+(5-1)),'     ',num2str(f3_delay_r1+J(3)+(4-1)),'     ',num2str(f4_delay_r10+J(4)+(4-1))]);
end