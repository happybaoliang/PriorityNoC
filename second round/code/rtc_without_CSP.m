function rtc_without_CSP()

scu=rtccurve([0 1 1]);
scuNI=rtccurve([0 1 1]);
scl=rtccurve([[0 0 0];[1 0 1]]);
sclNI=rtccurve([[0 0 0];[1 0 1]]);
scuRouter=rtcminconv(scu,rtcminconv(scu,rtcminconv(scu,scu)));
sclRouter=rtcminconv(scl,rtcminconv(scl,rtcminconv(scl,scl)));

%P=1,f8
acl8=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu8=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl8=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter))));
eqscu8=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter))));
fprintf('Delay Bound for Priority 1 (Flow 8):%3.3f cycles\n',rtch(acu8,eqscl8));

%P=2,f9
acl9=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu9=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl9=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu9=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 2 (Flow 9):%3.3f cycles\n',rtch(acu9,eqscl9));

%P=3,f10
acl10=rtcscale(rtcpjdl(4000000,0,0),512,0);
acu10=rtcscale(rtcpjdu(4000000,0,0),512,0);
eqscl10=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu10=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 3 (Flow 10):%3.3f cycles\n',rtch(acu10,eqscl10));

%P=4,f11
acl11=rtcscale(rtcpjdl(4000000,0,0),512,0);
acu11=rtcscale(rtcpjdu(4000000,0,0),512,0);
%leftover SC for f11 at R10
partialscla9P1=rtcminconv(sclNI,sclRouter);
partialscua9P1=rtcminconv(scuNI,scuRouter);
oaclb10P1=OutputACL(partialscla9P1,partialscua9P1,acl8);
oacub10P1=OutputACU(partialscla9P1,partialscua9P1,acu8);
loscla10P4=LeftOverSCL(sclRouter,oacub10P1);
loscua10P4=LeftOverSCU(scuRouter,oaclb10P1);
%leftover SC for f11 at R6
partialscla2P3=rtcminconv(sclNI,sclRouter);
partialscua2P3=rtcminconv(scuNI,scuRouter);
oaclb6P3=OutputACL(partialscla2P3,partialscua2P3,acl10);
oacub6P3=OutputACU(partialscla2P3,partialscua2P3,acu10);
loscla6P4=LeftOverSCL(sclRouter,oacub6P3);
loscua6P4=LeftOverSCU(scuRouter,oaclb6P3);
eqscl11=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,rtcminconv(loscla10P4,loscla6P4))));
eqscu11=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(scuRouter,rtcminconv(loscua10P4,loscua6P4))));
fprintf('Delay Bound for Priority 4 (Flow 11):%7.3f cycles\n',rtch(acu11,eqscl11));

%P=5,f12
acl12=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu12=rtcscale(rtcpjdu(4000000,0,0),38400,0);
%leftover SC for f12 at 2
partialscla2P1=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter)));
partialscua2P1=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter)));
oaclb2P1=OutputACL(partialscla2P1,partialscua2P1,acl8);
oacub2P1=OutputACL(partialscla2P1,partialscua2P1,acu8);
loscla2P5=LeftOverSCL(sclRouter,oacub2P1);
loscua2P5=LeftOverSCU(scuRouter,oaclb2P1);
eqscl12=rtcminconv(sclNI,rtcminconv(sclRouter,loscla2P5));
eqscu12=rtcminconv(scuNI,rtcminconv(scuRouter,loscua2P5));
fprintf('Delay Bound for Priority 5 (Flow 12):%7.3f cycles\n',rtch(acu12,eqscl12));

%P=6,f13
acl13=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu13=rtcscale(rtcpjdu(4000000,0,0),38400,0);
%leftover SC for f13 at R6
partialscla10P4=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,loscla10P4)));
partialscua10P4=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(scuRouter,loscua10P4)));
oaclb6P4=OutputACL(partialscla10P4,partialscua10P4,acl11);
oacub6P4=OutputACL(partialscla10P4,partialscua10P4,acu11);
loscla6P6=LeftOverSCL(loscla6P4,oacub6P4);
loscua6P6=LeftOverSCU(loscua6P4,oaclb6P4);
eqscl13=rtcminconv(sclNI,rtcminconv(sclRouter,loscla6P6));
eqscu13=rtcminconv(scuNI,rtcminconv(scuRouter,loscua6P6));
fprintf('Delay Bound for Priority 6 (Flow 13):%7.3f cycles\n',rtch(acu13,eqscl13));

%P=7,f14(CSP)
acl14=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu14=rtcscale(rtcpjdu(4000000,0,0),38400,0);
%leftover SC at NI for f14
losclaNIP7=LeftOverSCL(sclNI,acu8);
loscuaNIP7=LeftOverSCU(scuNI,acl8);
%leftover SC at R9 for f14
oaclb9P1=OutputACL(sclNI,scuNI,acl8);
oacub9P1=OutputACU(sclNI,scuNI,acu8);
loscla9P7=LeftOverSCL(sclRouter,oacub9P1);
loscua9P7=LeftOverSCU(scuRouter,oaclb9P1);
eqscl14=rtcminconv(losclaNIP7,rtcminconv(loscla9P7,sclRouter));
eqscu14=rtcminconv(loscuaNIP7,rtcminconv(loscua9P7,scuRouter));
% veqsclP1=rtcminconv(sclNI,sclRouter);
% veqscuP1=rtcminconv(scuNI,scuRouter);
% vlosclaP7=LeftOverSCL(veqsclP1,acu8);
% vloscuaP7=LeftOverSCU(veqscuP1,acl8);
% eqscl14=rtcminconv(vlosclaP7,sclRouter);
% eqscu14=rtcminconv(vloscuaP7,scuRouter);
fprintf('Delay Bound for Priority 7 (Flow 14):%7.3f cycles\n',rtch(acu14,eqscl14));

%P=8,f15
acl15=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu15=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl15=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu15=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 8 (Flow 15):%7.3f cycles\n',rtch(acu15,eqscl15));

%P=9,f16
acl16=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu16=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl16=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu16=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 9 (Flow 16):%7.3f cycles\n',rtch(acu16,eqscl16));

%P=10,f17
acl17=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu17=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl17=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu17=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 10 (Flow 17):%7.3f cycles\n',rtch(acu17,eqscl17));

%P=11,f18
acl18=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu18=rtcscale(rtcpjdu(4000000,0,0),38400,0);
eqscl18=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
eqscu18=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 11 (Flow 18):%7.3f cycles\n',rtch(acu18,eqscl18));

%P=12,f19(CSP)
acl19=rtcscale(rtcpjdl(4000000,0,0),38400,0);
acu19=rtcscale(rtcpjdu(4000000,0,0),38400,0);
%leftover SC at NI for f19
losclaNIP12=LeftOverSCL(sclNI,acu9);
loscuaNIP12=LeftOverSCU(scuNI,acl9);
%leftover SC at R16 for f19
oaclb16P12=OutputACL(sclNI,scuNI,acl9);
oacub16P12=OutputACU(sclNI,scuNI,acu9);
loscla16P12=LeftOverSCL(sclRouter,oacub16P12);
loscua16P12=LeftOverSCU(scuRouter,oaclb16P12);
%leftover SC at R15 for f19
partialeqsclb15P12=rtcminconv(sclNI,sclRouter);
partialeqscub15P12=rtcminconv(scuNI,scuRouter);
oaclb16P12=OutputACL(partialeqsclb15P12,partialeqscub15P12,acl9);
oacub16P12=OutputACU(partialeqsclb15P12,partialeqscub15P12,acu9);
loscla15P12=LeftOverSCL(sclRouter,oacub16P12);
loscua15P12=LeftOverSCU(scuRouter,oaclb16P12);
eqscl19=rtcminconv(losclaNIP12,rtcminconv(loscla16P12,loscla15P12));
eqscu19=rtcminconv(loscuaNIP12,rtcminconv(loscua16P12,loscua15P12));
% eqscl19=LeftOverSCL(eqscl9,acu9);
% eqscu19=LeftOverSCU(eqscu9,acl9);
fprintf('Delay Bound for Priority 12 (Flow 19):%7.3f cycles\n',rtch(acu19,eqscl19));

%P=13,f20
acl20=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu20=rtcscale(rtcpjdu(4000000,0,0),2048,0);
losclNIa2P13=LeftOverSCL(sclNI,acu10);
loscuNIa2P13=LeftOverSCU(scuNI,acl10);
partialeqsclb7P10=rtcminconv(sclNI,sclRouter);
partialeqscub7P10=rtcminconv(scuNI,scuRouter);
oaclb7P10=OutputACL(partialeqsclb7P10,partialeqsclb7P10,acl17);
oacub7P10=OutputACU(partialeqsclb7P10,partialeqsclb7P10,acu17);
loscla7P13=LeftOverSCL(sclRouter,acu17);
loscua7P13=LeftOverSCU(scuRouter,acl17);
eqscl20=rtcminconv(losclNIa2P13,rtcminconv(sclRouter,rtcminconv(sclRouter,loscla7P13)));
eqscu20=rtcminconv(loscuNIa2P13,rtcminconv(scuRouter,rtcminconv(scuRouter,loscua7P13)));
fprintf('Delay Bound for Priority 13 (Flow 20):%7.3f cycles\n',rtch(acu20,eqscl20));

%P=14,f21
acl21=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu21=rtcscale(rtcpjdu(4000000,0,0),2048,0);
partialeqsclb7P13=rtcminconv(losclNIa2P13,rtcminconv(sclRouter,sclRouter));
partialeqscub7P13=rtcminconv(loscuNIa2P13,rtcminconv(scuRouter,scuRouter));
oaclb7P13=OutputACL(partialeqsclb7P13,partialeqscub7P13,acl20);
oacub7P13=OutputACU(partialeqsclb7P13,partialeqscub7P13,acu20);
loscla7P14=LeftOverSCL(loscla7P13,oacub7P13);
loscua7P14=LeftOverSCU(loscua7P13,oaclb7P13);
eqscl21=rtcminconv(sclNI,rtcminconv(sclRouter,loscla7P14));
eqscu21=rtcminconv(scuNI,rtcminconv(scuRouter,loscua7P14));
fprintf('Delay Bound for Priority 14 (Flow 21):%7.3f cycles\n',rtch(acu21,eqscl21));

%P=15,f22
acl22=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu22=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at R7 for f22
partialeqsclb7P14=rtcminconv(sclNI,sclRouter);
partialeqscub7P14=rtcminconv(scuNI,scuRouter);
oaclb7P14=OutputACL(partialeqsclb7P14,partialeqscub7P14,acl21);
oacub7P14=OutputACU(partialeqsclb7P14,partialeqscub7P14,acu21);
loscla7P15=LeftOverSCL(loscla7P14,oacub7P14);
loscua7P15=LeftOverSCU(loscua7P14,oaclb7P14);
eqscl22=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,loscla7P15)));
eqscu22=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(sclRouter,loscua7P15)));
fprintf('Delay Bound for Priority 15 (Flow 22):%7.3f cycles\n',rtch(acu22,eqscl22));

%P=16,f23(CSP)
acl23=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu23=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at R11 for f23 
partialeqsclb11P15=rtcminconv(sclNI,sclRouter);
partialeqscub11P15=rtcminconv(scuNI,scuRouter);
oaclb11P15=OutputACL(partialeqsclb11P15,partialeqscub11P15,acl22);
oacub11P15=OutputACU(partialeqsclb11P15,partialeqscub11P15,acu22);
loscla11P16=LeftOverSCL(sclRouter,oacub11P15);
loscua11P16=LeftOverSCU(scuRouter,oaclb11P15);
%leftover SC　at R7 for f23
partialeqsclb7P15=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
partialeqscub7P15=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
oaclb7P15=OutputACL(partialeqsclb7P15,partialeqscub7P15,acl22);
oacub7P15=OutputACU(partialeqsclb7P15,partialeqscub7P15,acu22);
loscla7P16=LeftOverSCL(loscla7P15,oacub7P15);
loscua7P16=LeftOverSCU(loscua7P15,oaclb7P15);
eqscl23=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,rtcminconv(loscla11P16,loscla7P16))));
eqscu23=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(sclRouter,rtcminconv(loscua11P16,loscua7P16))));
% veqsclP15=rtcminconv(sclRouter,loscla7P15);
% veqscuP15=rtcminconv(scuRouter,loscua7P15);
% vlosclP16=LeftOverSCL(veqsclP15,oacub11P15);
% vloscuP16=LeftOverSCU(veqscuP15,oaclb11P15);
% eqscl23=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(sclRouter,vlosclP16)));
% eqscu23=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(scuRouter,vloscuP16)));
fprintf('Delay Bound for Priority 16 (Flow 23):%7.3f cycles\n',rtch(acu23,eqscl23));

%P17,f24
acl24=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu24=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at R2 for f24
oaclb2P3=OutputACL(sclNI,scuNI,acl10);
oacub2P3=OutputACU(sclNI,scuNI,acu10);
loscla2P17=LeftOverSCL(sclRouter,oacub2P3);
loscua2P17=LeftOverSCU(scuRouter,oaclb2P3);
%leftover SC at R10 for f24(CSP)
partialsclb10P7=rtcminconv(losclaNIP7,loscla9P7);
partialscub10P7=rtcminconv(loscuaNIP7,loscua9P7);
oaclb10P7=OutputACL(partialsclb10P7,partialscub10P7,acl14);
oacub10P7=OutputACU(partialsclb10P7,partialscub10P7,acu14);
loscla10P17=LeftOverSCL(sclRouter,oacub10P7);
loscua10P17=LeftOverSCU(scuRouter,oaclb10P7);
eqscl24=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(loscla2P17,rtcminconv(sclRouter,loscla10P17))));
eqscu24=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(loscua2P17,rtcminconv(scuRouter,loscua10P17))));
fprintf('Delay Bound for Priority 17 (Flow 24):%7.3f cycles\n',rtch(acu24,eqscl24));

%P=18,f25(CSP)
acl25=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu25=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at R6 for f25
partialeqscl24=rtcminconv(sclNI,rtcminconv(sclRouter,loscla2P17));
partialeqscu24=rtcminconv(scuNI,rtcminconv(scuRouter,loscua2P17));
oaclb6P17=OutputACL(partialeqscl24,partialeqscu24,acl24);
oacub6P17=OutputACU(partialeqscl24,partialeqscu24,acu24);
loscla6P18=LeftOverSCL(sclRouter,oacub6P17);
loscua6P18=LeftOverSCU(scuRouter,oaclb6P17);
%leftover SC at R10 for f25
partialeqsclb10P17=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(loscla2P17,sclRouter)));
partialeqscub10P17=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(loscua2P17,scuRouter)));
oaclb10P17=OutputACL(partialeqsclb10P17,partialeqscub10P17,acl24);
oacub10P17=OutputACU(partialeqsclb10P17,partialeqscub10P17,acu24);
loscla10P18=LeftOverSCL(loscla10P17,oacub10P17);
loscua10P18=LeftOverSCU(loscua10P17,oaclb10P17);
eqscl25=rtcminconv(sclNI,rtcminconv(sclRouter,rtcminconv(loscla6P18,loscla10P18)));
eqscu25=rtcminconv(scuNI,rtcminconv(scuRouter,rtcminconv(loscua6P18,loscua10P18)));
% veqsclP17=rtcminconv(sclRouter,loscla10P17);
% veqscuP17=rtcminconv(scuRouter,loscua10P17);
% vlosclP18=LeftOverSCL(veqsclP17,oacub6P17);
% vloscuP18=LeftOverSCU(veqscuP17,oaclb6P17);
% eqscl25=rtcminconv(sclNI,rtcminconv(sclRouter,vlosclP18));
% eqscu25=rtcminconv(scuNI,rtcminconv(scuRouter,vloscuP18));
fprintf('Delay Bound for Priority 18 (Flow 25):%7.3f cycles\n',rtch(acu25,eqscl25));

%P=19,f26
acl26=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu26=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at 10 for f26
partialeqsclb10P18=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
partialeqscub10P18=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
oaclb10P18=OutputACL(partialeqsclb10P18,partialeqscub10P18,acl26);
oacub10P18=OutputACU(partialeqsclb10P18,partialeqscub10P18,acu26);
loscla10P19=LeftOverSCL(loscla10P18,oacub10P18);
loscua10P19=LeftOverSCU(loscua10P18,oaclb10P18);
eqscl26=rtcminconv(sclNI,rtcminconv(sclRouter,loscla10P19));
eqscu26=rtcminconv(scuNI,rtcminconv(scuRouter,loscua10P19));
fprintf('Delay Bound for Priority 19 (Flow 26):%7.3f cycles\n',rtch(acu26,eqscl26));

%P=20,f27(CSP)
acl27=rtcscale(rtcpjdl(4000000,0,0),2048,0);
acu27=rtcscale(rtcpjdu(4000000,0,0),2048,0);
%leftover SC at NI for f27
losclNI=LeftOverSCL(sclNI,acu11);
loscuNI=LeftOverSCU(scuNI,acl11);
%leftover SC at R15 for f27
oaclb15P4=OutputACL(losclNI,loscuNI,acl11);
oacub15P4=OutputACU(losclNI,loscuNI,acu11);
loscla15P20=LeftOverSCL(sclRouter,oacub15P4);
loscua15P20=LeftOverSCU(scuRouter,oaclb15P4);
%leftover SC at R14 for f27
partialeqsclb14P4=rtcminconv(sclNI,sclRouter);
partialeqscub14P4=rtcminconv(scuNI,scuRouter);
oaclb14P4=OutputACL(partialeqsclb14P4,partialeqscub14P4,acl11);
oacub14P4=OutputACU(partialeqsclb14P4,partialeqscub14P4,acu11);
loscla14P20=LeftOverSCL(sclRouter,oacub14P4);
loscua14P20=LeftOverSCU(scuRouter,oaclb14P4);
% veqsclP4=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
% veqscuP4=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
% vlosclP20=LeftOverSCL(veqsclP4,acu11);
% vloscuP20=LeftOverSCU(veqscuP4,acl11);
%leftover SC at 10 for f27
partialsclb10P19=rtcminconv(sclNI,sclRouter);
partialscub10P19=rtcminconv(scuNI,scuRouter);
oaclb10P19=OutputACL(partialsclb10P19,partialscub10P19,acl26);
oacub10P19=OutputACU(partialsclb10P19,partialscub10P19,acu26);
loscla10P20=LeftOverSCL(loscla10P19,oacub10P19);
loscua10P20=LeftOverSCU(loscua10P19,oaclb10P19);
eqscl27=rtcminconv(losclNI,rtcminconv(loscla15P20,rtcminconv(loscla14P20,loscla10P20)));
eqscu27=rtcminconv(loscuNI,rtcminconv(loscua15P20,rtcminconv(loscua14P20,loscua10P20)));
% eqscl27=rtcminconv(vlosclP20,loscla10P20);
% eqscu27=rtcminconv(vloscuP20,loscua10P20);
fprintf('Delay Bound for Priority 20 (Flow 27):%7.3f cycles\n',rtch(acu27,eqscl27));

%P=21,f28(CSP)
acl28=rtcscale(rtcpjdl(4000000,0,0),8192,0);
acu28=rtcscale(rtcpjdu(4000000,0,0),8192,0);
%leftover SC at NI for f28
losclNIP21=LeftOverSCL(sclNI,acu25);
loscuNIP21=LeftOverSCU(scuNI,acl25);
%leftover SC at R7 for f28
oaclb7P18=OutputACL(losclNIP21,loscuNIP21,acl25);
oacub7P18=OutputACU(losclNIP21,loscuNIP21,acu25);
loscla7P21=LeftOverSCL(sclRouter,oacub7P18);
loscua7P21=LeftOverSCU(scuRouter,oaclb7P18);
%leftover SC at R11 for f28
partialeqsclb11P11=rtcminconv(sclNI,sclRouter);
partialeqscub11P11=rtcminconv(scuNI,scuRouter);
oaclb11P11=OutputACL(partialeqsclb11P11,partialeqscub11P11,acl18);
oacub11P11=OutputACU(partialeqsclb11P11,partialeqscub11P11,acu18);
loscla11P21=LeftOverSCL(sclRouter,oacub11P11);
loscua11P21=LeftOverSCU(scuRouter,oaclb11P11);
eqscl28=rtcminconv(losclNIP21,rtcminconv(loscla7P21,loscla11P21));
eqscu28=rtcminconv(loscuNIP21,rtcminconv(loscua7P21,loscua11P21));
% veqsclP18=rtcminconv(sclNI,sclRouter);
% veqscuP18=rtcminconv(scuNI,scuRouter);
% vlosclP21=LeftOverSCL(veqsclP18,acu25);
% vloscuP21=LeftOverSCU(veqscuP18,acl25);
% eqscl28=rtcminconv(vlosclP21,loscla11P21);
fprintf('Delay Bound for Priority 21 (Flow 28):%7.3f cycles\n',rtch(acu28,eqscl28));

%P=22,f29(CSP)
acl29=rtcscale(rtcpjdl(4000000,0,0),8192,0);
acu29=rtcscale(rtcpjdu(4000000,0,0),8192,0);
%leftover SC at R11 for f29
partialsclb11P21=rtcminconv(losclNIP21,loscla7P21);
partialscub11P21=rtcminconv(loscuNIP21,loscua7P21);
oaclb11P21=OutputACL(partialsclb11P21,partialscub11P21,acl28);
oacub11P21=OutputACU(partialsclb11P21,partialscub11P21,acu28);
loscla11P22=LeftOverSCL(loscla11P21,oacub11P21);
loscua11P22=LeftOverSCU(loscua11P21,oaclb11P21);
%leftover SC at NI10 for f29
losclNIP29=LeftOverSCL(sclNI,acu22);
loscuNIP29=LeftOverSCU(scuNI,acl22);
%leftover SC at R10 for f29
oaclb10P15=OutputACL(sclNI,scuNI,acl22);
oacub10P15=OutputACU(sclNI,scuNI,acu22);
loscla10P22=LeftOverSCL(sclRouter,oacub10P15);
loscua10P22=LeftOverSCU(scuRouter,oaclb10P15);
eqscl29=rtcminconv(losclNIP29,rtcminconv(loscla10P22,loscla11P22));
eqscu29=rtcminconv(loscuNIP29,rtcminconv(loscua10P22,loscua11P22));
% veqsclP15=rtcminconv(sclNI,sclRouter);
% veqscuP15=rtcminconv(scuNI,scuRouter);
% vlosclP22=LeftOverSCL(veqsclP15,acu22);
% vloscuP22=LeftOverSCU(veqscuP15,acl22);
% eqscl29=rtcminconv(vlosclP22,loscla11P22);
% eqscu29=rtcminconv(vloscuP22,loscua11P22);
fprintf('Delay Bound for Priority 22 (Flow 29):%7.3f cycles\n',rtch(acu29,eqscl29));

%P=23,f30(CSP)
acl30=rtcscale(rtcpjdl(4000000,0,0),4096,0);
acu30=rtcscale(rtcpjdu(4000000,0,0),4096,0);
%leftover SC at NI for f30
losclNIP23=LeftOverSCL(sclNI,acu26);
loscuNIP23=LeftOverSCU(scuNI,acl26);
%leftover SC at R11 for f30
oaclb11P19=OutputACL(sclNI,scuNI,acl26);
oacub11P19=OutputACU(sclNI,scuNI,acu26);
loscla11P23=LeftOverSCL(sclRouter,oacub11P19);
loscua11P23=LeftOverSCU(scuRouter,oaclb11P19);
eqscl30=rtcminconv(losclNIP23,rtcminconv(loscla11P23,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter))));
eqscu30=rtcminconv(loscuNIP23,rtcminconv(loscua11P23,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter))));
% veqsclP19=rtcminconv(sclNI,sclRouter);
% veqscuP19=rtcminconv(scuNI,scuRouter);
% vlosclP23=LeftOverSCL(veqsclP19,acu26);
% vloscuP23=LeftOverSCU(veqscuP19,acl26);
% eqscl30=rtcminconv(vlosclP23,rtcminconv(sclRouter,sclRouter));
% eqscu30=rtcminconv(vloscuP23,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 23 (Flow 30):%7.3f cycles\n',rtch(acu30,eqscl30));

%P=24,f5(CSP)
acl5=rtcscale(rtcpjdl(10000000,0,0),512,0);
acu5=rtcscale(rtcpjdu(10000000,0,0),512,0);
%leftover SC at NI for f5
losclNIP24=LeftOverSCL(sclNI,acu21);
loscuNIP24=LeftOverSCU(scuNI,acl21);
%leftover SC at R6 for f5
oaclb6P14=OutputACL(sclNI,scuNI,acl21);
oacub6P14=OutputACU(sclNI,scuNI,acu21);
loscla6P24=LeftOverSCL(sclRouter,oacub6P14);
loscua6P24=LeftOverSCU(scuRouter,oaclb6P14);
eqscl5=rtcminconv(losclNIP24,rtcminconv(loscla6P24,rtcminconv(sclRouter,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter)))));
eqscu5=rtcminconv(loscuNIP24,rtcminconv(loscua6P24,rtcminconv(scuRouter,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter)))));
% veqsclP14=rtcminconv(sclNI,sclRouter);
% veqscuP14=rtcminconv(scuNI,scuRouter);
% vlosclP24=LeftOverSCL(veqsclP14,acu21);
% vloscuP24=LeftOverSCU(veqscuP14,acl21);
% eqscl5=rtcminconv(vlosclP24,rtcminconv(sclRouter,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter))));
% eqscu5=rtcminconv(vloscuP24,rtcminconv(scuRouter,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter))));
fprintf('Delay Bound for Priority 24 (Flow 5):%7.3f cycles\n',rtch(acu5,eqscl5));

%P=25,f6
acl6=rtcscale(rtcpjdl(10000000,0,0),512,0);
acu6=rtcscale(rtcpjdu(10000000,0,0),512,0);
%leftover SC at NI12 for f6
losclNIP25=LeftOverSCL(sclNI,acu18);
loscuNIP25=LeftOverSCU(scuNI,acl18);
%leftover SC at R11 for f6
oaclb11P23=OutputACL(losclNIP23,loscuNIP23,acl30);
oacub11P23=OutputACU(losclNIP23,loscuNIP23,acu30);
loscla11P25=LeftOverSCL(loscla11P23,oacub11P23);
loscua11P25=LeftOverSCU(loscua11P23,oaclb11P23);
%leftover SC at R10 for f6
partialeqscl11=rtcminconv(sclNI,rtcminconv(sclRouter,sclRouter));
partialeqscu11=rtcminconv(scuNI,rtcminconv(scuRouter,scuRouter));
oaclb10P4=OutputACL(partialeqscl11,partialeqscu11,acl11);
oacub10P4=OutputACU(partialeqscl11,partialeqscu11,acu11);
loscla10P25=LeftOverSCL(loscla10P4,oacub10P4);
loscua10P25=LeftOverSCU(loscua10P4,oaclb10P4);
%leftover SC at R6 for f6
partialeqsclP6=rtcminconv(sclNI,sclRouter);
partialeqscuP6=rtcminconv(scuNI,scuRouter);
oaclb6P6=OutputACL(partialeqsclP6,partialeqscuP6,acl13);
oacub6P6=OutputACU(partialeqsclP6,partialeqscuP6,acu13);
loscla6P25=LeftOverSCL(loscla6P6,oacub6P6);
loscua6P25=LeftOverSCU(loscua6P6,oaclb6P6);
eqscl6=rtcminconv(losclNIP25,rtcminconv(sclRouter,rtcminconv(loscla11P25,rtcminconv(loscla10P25,loscla6P25))));
eqscu6=rtcminconv(loscuNIP25,rtcminconv(scuRouter,rtcminconv(loscua11P25,rtcminconv(loscua10P25,loscua6P25))));
fprintf('Delay Bound for Priority 25 (Flow 6):%7.3f cycles\n',rtch(acu6,eqscl6));

%P=26,f7
acl7=rtcscale(rtcpjdl(10000000,0,0),1024,0);
acu7=rtcscale(rtcpjdu(10000000,0,0),1024,0);
%leftover SC at NI for f7
losclNIP26=LeftOverSCL(losclNIP24,acu5);
loscuNIP26=LeftOverSCU(loscuNIP24,acl5);
%leftover SC at R6 for f7
partialeqsclb6P18=rtcminconv(sclNI,sclRouter);
partialeqscub6P18=rtcminconv(scuNI,scuRouter);
oaclb6P18=OutputACL(partialeqsclb6P18,partialeqscub6P18,acl25);
oacub6P18=OutputACU(partialeqsclb6P18,partialeqscub6P18,acu25);
loscla6P26=LeftOverSCL(loscla6P18,oacub6P18);
loscua6P26=LeftOverSCU(loscua6P18,oaclb6P18);
%leftover SC at R14 for f7
partialeqscl15=rtcminconv(sclNI,sclRouter);
partialeqscu15=rtcminconv(scuNI,scuRouter);
oaclb14P8=OutputACL(partialeqscl15,partialeqscu15,acl15);
oacub14P8=OutputACU(partialeqscl15,partialeqscu15,acu15);
loscla14P26=LeftOverSCL(sclRouter,oacub14P8);
loscua14P26=LeftOverSCU(scuRouter,oaclb14P8);
eqscl7=rtcminconv(losclNIP26,rtcminconv(loscla6P26,rtcminconv(sclRouter,loscla14P26)));
eqscu7=rtcminconv(loscuNIP26,rtcminconv(loscua6P26,rtcminconv(scuRouter,loscua14P26)));
fprintf('Delay Bound for Priority 26 (Flow 7):%7.3f cycles\n',rtch(acu7,eqscl7));

%P=27,f32(CSP)
acl32=rtcscale(rtcpjdl(10000000,0,0),1024,0);
acu32=rtcscale(rtcpjdu(10000000,0,0),1024,0);
%leftover SC at NI for f32
losclNIP27=LeftOverSCL(sclNI,acu15);
loscuNIP27=LeftOverSCU(scuNI,acl15);
%leftover SC at R9 for f32
partialeqscl30=rtcminconv(losclNIP23,rtcminconv(loscla11P23,sclRouter));
partialeqscu30=rtcminconv(loscuNIP23,rtcminconv(loscua11P23,scuRouter));
oaclb9P23=OutputACL(partialeqscl30,partialeqscu30,acl30);
oacub9P23=OutputACU(partialeqscl30,partialeqscu30,acu30);
loscla9P27=LeftOverSCL(sclRouter,oacub9P23);
loscua9P27=LeftOverSCU(scuRouter,oaclb9P23);
%leftover SC at R5 for f32
partialeqscl30=rtcminconv(losclNIP23,rtcminconv(loscla11P23,rtcminconv(sclRouter,sclRouter)));
partialeqscu30=rtcminconv(loscuNIP23,rtcminconv(loscua11P23,rtcminconv(scuRouter,sclRouter)));
oaclb5P23=OutputACL(partialeqscl30,partialeqscu30,acl30);
oacub5P23=OutputACU(partialeqscl30,partialeqscu30,acu30);
loscla5P27=LeftOverSCL(sclRouter,oacub5P23);
loscua5P27=LeftOverSCU(scuRouter,oaclb5P23);
eqscl32=rtcminconv(losclNIP27,rtcminconv(sclRouter,rtcminconv(loscla9P27,loscla5P27)));
eqscu32=rtcminconv(loscuNIP27,rtcminconv(scuRouter,rtcminconv(loscua9P27,loscua5P27)));
% veqsclP23=rtcminconv(sclRouter,sclRouter);
% veqscuP23=rtcminconv(scuRouter,scuRouter);
% vlosclP27=LeftOverSCL(veqsclP23,oacub9P23);
% vloscuP27=LeftOverSCL(veqscuP23,oaclb9P23);
% eqscl32=rtcminconv(losclNIP27,rtcminconv(sclRouter,vlosclP27));
% eqscu32=rtcminconv(loscuNIP27,rtcminconv(scuRouter,vloscuP27));
fprintf('Delay Bound for Priority 27 (Flow 32):%7.3f cycles\n',rtch(acu32,eqscl32));

%P=28,f35
acl35=rtcscale(rtcpjdl(10000000,0,0),512,0);
acu35=rtcscale(rtcpjdu(10000000,0,0),512,0);
%leftover SC at NI3 for f35
losclNIP28=LeftOverSCL(sclNI,acu24);
loscuNIP28=LeftOverSCU(scuNI,acl24);
eqscl35=rtcminconv(losclNIP28,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter)));
eqscu35=rtcminconv(loscuNIP28,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter)));
fprintf('Delay Bound for Priority 28 (Flow 35):%7.3f cycles\n',rtch(acu35,eqscl35));

%P=29,f37
acl37=rtcscale(rtcpjdl(10000000,0,0),1024,0);
acu37=rtcscale(rtcpjdu(10000000,0,0),1024,0);
%leftover SC at R12 for f37
losclNIP29=LeftOverSCL(losclNIP25,acu6);
loscuNIP29=LeftOverSCU(loscuNIP25,acl6);
%leftover SC at R8 for f37
partialeqscl35=rtcminconv(losclNIP28,rtcminconv(sclRouter,sclRouter));
partialeqscu35=rtcminconv(loscuNIP28,rtcminconv(scuRouter,scuRouter));
oaclb8P28=OutputACL(partialeqscl35,partialeqscu35,acl35);
oacub8P28=OutputACU(partialeqscl35,partialeqscu35,acu35);
loscla8P29=LeftOverSCL(sclRouter,oacub8P28);
loscua8P29=LeftOverSCU(scuRouter,oaclb8P28);
eqscl37=rtcminconv(losclNIP29,rtcminconv(sclRouter,loscla8P29));
eqscu37=rtcminconv(loscuNIP29,rtcminconv(scuRouter,loscua8P29));
fprintf('Delay Bound for Priority 29 (Flow 37):%7.3f cycles\n',rtch(acu37,eqscl37));

%P=30,f38(CSP)
acl38=rtcscale(rtcpjdl(10000000,0,0),1024,0);
acu38=rtcscale(rtcpjdu(10000000,0,0),1024,0);
%leftover SC at NI8 for f38
losclNIP30=LeftOverSCL(sclNI,acu17);
loscuNIP30=LeftOverSCU(scuNI,acl17);
%leftover SC at R7 for f38
oaclb7P18=OutputACL(sclNI,scuNI,acl25);
oacub7P18=OutputACU(sclNI,scuNI,acu25);
loscla7P30=LeftOverSCL(sclRouter,oacub7P18);
loscua7P30=LeftOverSCU(scuRouter,oaclb7P18);
%leftover SC at R6 for f38
oaclb6P26=OutputACL(losclNIP26,loscuNIP26,acl7);
oacub6P26=OutputACU(losclNIP26,loscuNIP26,acu7);
loscla6P30=LeftOverSCL(loscla6P26,oacub6P26);
loscua6P30=LeftOverSCU(loscua6P26,oaclb6P26);
%leftover SC at R10 for f38
partialsclb10P26=rtcminconv(losclNIP26,loscla6P26);
partialscub10P26=rtcminconv(loscuNIP26,loscua6P26);
oaclb10P26=OutputACL(partialsclb10P26,partialscub10P26,acl7);
oacub10P26=OutputACU(partialsclb10P26,partialscub10P26,acu7);
loscla10P30=LeftOverSCL(sclRouter,oacub10P26);
loscua10P30=LeftOverSCU(scuRouter,oaclb10P26);
%leftover SC at R14 for f38
partialeqscl7=rtcminconv(losclNIP26,rtcminconv(loscla6P26,sclRouter));
partialeqscu7=rtcminconv(loscuNIP26,rtcminconv(loscua6P26,scuRouter));
oaclb14P26=OutputACL(partialeqscl7,partialeqscu7,acl7);
oacub14P26=OutputACU(partialeqscl7,partialeqscu7,acu7);
loscla14P30=LeftOverSCL(loscla14P26,oacub14P26);
loscua14P30=LeftOverSCU(loscua14P26,oaclb14P26);
eqscl38=rtcminconv(losclNIP30,rtcminconv(sclRouter,rtcminconv(loscla7P30,rtcminconv(loscla6P30,rtcminconv(loscla10P30,loscla14P30)))));
eqscu38=rtcminconv(loscuNIP30,rtcminconv(sclRouter,rtcminconv(loscua7P30,rtcminconv(loscua6P30,rtcminconv(loscua10P30,loscua14P30)))));
% veqsclP26=rtcminconv(loscla6P26,rtcminconv(sclRouter,loscla14P26));
% veqscuP26=rtcminconv(loscua6P26,rtcminconv(scuRouter,loscua14P26));
% vlosclb14P30=LeftOverSCL(veqsclP26,oacub6P26);
% vloscub14P30=LeftOverSCU(veqscuP26,oaclb6P26);
% eqscl38=rtcminconv(losclNIP30,rtcminconv(sclRouter,rtcminconv(loscla7P30,vlosclb14P30)));
% eqscu38=rtcminconv(loscuNIP30,rtcminconv(scuRouter,rtcminconv(loscua7P30,vloscub14P30)));
fprintf('Delay Bound for Priority 30 (Flow 38):%7.3f cycles\n',rtch(acu38,eqscl38));

%P=31,f1(CSP)
acl1=rtcscale(rtcpjdl(50000000,0,0),1024,0);
acu1=rtcscale(rtcpjdu(50000000,0,0),1024,0);
%leftover SC at NI1 for f1
losclNIP31=LeftOverSCL(sclNI,acu12);
loscuNIP31=LeftOverSCU(scuNI,acl12);
%leftover SC at R1 for f1
oaclb1P5=OutputACL(sclNI,scuNI,acl12);
oacub1P5=OutputACU(sclNI,scuNI,acu12);
loscla1P31=LeftOverSCL(sclRouter,oacub1P5);
loscua1P31=LeftOverSCU(scuRouter,oaclb1P5);
% veqsclP5=rtcminconv(sclNI,sclRouter);
% veqscuP5=rtcminconv(scuNI,scuRouter);
% vlosclP31=LeftOverSCL(veqsclP5,acu12);
% vloscuP31=LeftOverSCU(veqscuP5,acl12);
%leftover SC at R2 for f1
partialeqscl24=rtcminconv(sclNI,sclRouter);
partialeqscu24=rtcminconv(scuNI,scuRouter);
oaclb2P17=OutputACL(partialeqscl24,partialeqscu24,acl24);
oacub2P17=OutputACU(partialeqscl24,partialeqscu24,acu24);
loscla2P31=LeftOverSCL(loscla2P17,oacub2P17);
loscua2P31=LeftOverSCU(loscua2P17,oaclb2P17);
%leftover SC at R6 for f1
partialeqscl6=rtcminconv(losclNIP25,rtcminconv(sclRouter,rtcminconv(loscla11P25,loscla10P25)));
partialeqscu6=rtcminconv(loscuNIP25,rtcminconv(scuRouter,rtcminconv(loscua11P25,loscua10P25)));
oaclb6P25=OutputACL(partialeqscl6,partialeqscu6,acl6);
oacub6P25=OutputACU(partialeqscl6,partialeqscu6,acu6);
loscla6P31=LeftOverSCL(loscla6P25,oacub6P25);
loscua6P31=LeftOverSCU(loscua6P25,oaclb6P25);
eqscl1=rtcminconv(losclNIP31,rtcminconv(loscla1P31,rtcminconv(loscla2P31,loscla6P31)));
eqscu1=rtcminconv(loscuNIP31,rtcminconv(loscua1P31,rtcminconv(loscua2P31,loscua6P31)));
% eqscl1=rtcminconv(vlosclP31,rtcminconv(loscla2P31,loscla6P31));
% eqscu1=rtcminconv(vloscuP31,rtcminconv(loscua2P31,loscua6P31));
fprintf('Delay Bound for Priority 31 (Flow 1):%7.3f cycles\n',rtch(acu1,eqscl1));

%P=32,f2
acl2=rtcscale(rtcpjdl(50000000,0,0),2048,0);
acu2=rtcscale(rtcpjdu(50000000,0,0),2048,0);
%leftover SC at NI6 for f2
losclNIP32=LeftOverSCL(losclNIP26,acu7);
loscuNIP32=LeftOverSCU(loscuNIP26,acl7);
eqscl2=rtcminconv(losclNIP32,rtcminconv(sclRouter,rtcminconv(sclRouter,sclRouter)));
eqscu2=rtcminconv(loscuNIP32,rtcminconv(scuRouter,rtcminconv(scuRouter,scuRouter)));
fprintf('Delay Bound for Priority 32 (Flow 2):%7.3f cycles\n',rtch(acu2,eqscl2));

%P=33,f3(CSP)
acl3=rtcscale(rtcpjdl(50000000,0,0),16384,0);
acu3=rtcscale(rtcpjdu(50000000,0,0),16384,0);
%leftover SC at NI9 for f3
losclNIP33=LeftOverSCL(losclaNIP7,acu14);
loscuNIP33=LeftOverSCU(loscuaNIP7,acl14);
%leftover SC at R9 for f3
oaclb9P7=OutputACL(losclaNIP7,loscuaNIP7,acl14);
oacub9P7=OutputACU(losclaNIP7,loscuaNIP7,acu14);
loscla9P33=LeftOverSCL(loscla9P7,oacub9P7);
loscua9P33=LeftOverSCU(loscua9P7,oaclb9P7);
% veqsclP7=rtcminconv(losclaNIP7,loscla9P7);
% veqscuP7=rtcminconv(loscuaNIP7,loscua9P7);
% vlosclP33=LeftOverSCL(veqsclP7,acu14);
% vloscuP33=LeftOverSCU(veqscuP7,acl14);
%leftover SC at R10 for f3
partialeqscl6=rtcminconv(losclNIP25,sclRouter);
partialeqscu6=rtcminconv(loscuNIP25,scuRouter);
oaclb10P25=OutputACL(partialeqscl6,partialeqscu6,acl6);
oacub10P25=OutputACU(partialeqscl6,partialeqscu6,acu6);
loscla10P33=LeftOverSCL(loscla10P25,oacub10P25);
loscua10P33=LeftOverSCU(loscua10P25,oaclb10P25);
%leftover SC at R6 for f3
partialeqscl1=rtcminconv(losclNIP31,rtcminconv(loscla1P31,loscla2P31));
partialeqscu1=rtcminconv(loscuNIP31,rtcminconv(loscua1P31,loscua2P31));
oaclb6P31=OutputACL(partialeqscl1,partialeqscu1,acl1);
oacub6P31=OutputACU(partialeqscl1,partialeqscu1,acu1);
loscla6P33=LeftOverSCL(loscla6P31,oacub6P31);
loscua6P33=LeftOverSCU(loscua6P31,oaclb6P31);
eqscl3=rtcminconv(losclNIP33,rtcminconv(loscla9P33,rtcminconv(loscla10P33,loscla6P33)));
eqscu3=rtcminconv(loscuNIP33,rtcminconv(loscua9P33,rtcminconv(loscua10P33,loscua6P33)));
% eqscl3=rtcminconv(vlosclP33,rtcminconv(loscla10P33,loscla6P33));
% eqscu3=rtcminconv(vloscuP33,rtcminconv(loscua10P33,loscua6P33));
fprintf('Delay Bound for Priority 33 (Flow 3):%7.3f cycles\n',rtch(acu3,eqscl3));

%P=34,f4(CSP)
acl4=rtcscale(rtcpjdl(50000000,0,0),16384,0);
acu4=rtcscale(rtcpjdu(50000000,0,0),16384,0);
%leftover SC at NI9 for f4
losclNIP34=LeftOverSCL(losclNIP33,acu3);
loscuNIP34=LeftOverSCU(loscuNIP33,acl3);
%leftover SC at R9 for f4
partialeqscl32=rtcminconv(losclNIP27,sclRouter);
partialeqscu32=rtcminconv(loscuNIP27,scuRouter);
oaclb9P27=OutputACL(partialeqscl32,partialeqscu32,acl32);
oacub9P27=OutputACU(partialeqscl32,partialeqscu32,acu32);
loscla9P34=LeftOverSCL(sclRouter,oacub9P27);
loscua9P34=LeftOverSCU(scuRouter,oaclb9P27);
%leftover SC at R5 for f4
partialeqscl32=rtcminconv(losclNIP27,rtcminconv(sclRouter,loscla9P27));
partialeqscu32=rtcminconv(loscuNIP27,rtcminconv(scuRouter,loscua9P27));
oaclb5P27=OutputACL(partialeqscl32,partialeqscu32,acl32);
oacub5P27=OutputACU(partialeqscl32,partialeqscu32,acu32);
loscla5P34=LeftOverSCL(loscla5P27,oacub5P27);
loscua5P34=LeftOverSCU(loscua5P27,oaclb5P27);
eqscl4=rtcminconv(losclNIP34,rtcminconv(loscla9P34,loscla5P34));
eqscu4=rtcminconv(loscuNIP34,rtcminconv(loscua9P34,loscua5P34));
% %以下4行在支持CSP时多余
% % veqsclP23=rtcminconv(sclRouter,sclRouter);
% % veqscuP23=rtcminconv(scuRouter,scuRouter);
% % vlosclP27=LeftOverSCL(veqsclP23,oacub9P23);
% % vloscuP27=LeftOverSCL(veqscuP23,oaclb9P23);
% vlosclP34=LeftOverSCL(vlosclP27,acu32);
% vloscuP34=LeftOverSCU(vloscuP27,acl32);
% eqscl4=rtcminconv(losclNIP34,vlosclP34);
% eqscu4=rtcminconv(loscuNIP34,vloscuP34);
fprintf('Delay Bound for Priority 34 (Flow 4):%7.3f cycles\n',rtch(acu4,eqscl4));

%P=35,f31
acl31=rtcscale(rtcpjdl(50000000,0,0),1024,0);
acu31=rtcscale(rtcpjdu(50000000,0,0),1024,0);
%leftover SC at NI for f31
losclNIP35=LeftOverSCL(losclNIP31,acu1);
loscuNIP35=LeftOverSCU(loscuNIP31,acl1);
%leftover SC at R5 for f31
partialeqsclP34=rtcminconv(losclNIP34,loscla9P34);
partialeqscuP34=rtcminconv(loscuNIP34,loscua9P34);
oaclb5P34=OutputACL(partialeqsclP34,partialeqscuP34,acl4);
oacub5P34=OutputACU(partialeqsclP34,partialeqscuP34,acu4);
loscla5P35=LeftOverSCL(loscla5P34,oacub5P34);
loscua5P35=LeftOverSCU(loscua5P34,oaclb5P34);
eqscl31=rtcminconv(losclNIP35,rtcminconv(sclRouter,loscla5P35));
eqscu31=rtcminconv(loscuNIP35,rtcminconv(scuRouter,loscua5P35));
fprintf('Delay Bound for Priority 35 (Flow 31):%7.3f cycles\n',rtch(acu31,eqscl31));

%P=36,f34(CSP)
acl34=rtcscale(rtcpjdl(50000000,0,0),2048,0);
acu34=rtcscale(rtcpjdu(50000000,0,0),2048,0);
%leftover SC at NI13 for f34
losclNIP36=LeftOverSCL(losclNIP27,acu32);
loscuNIP36=LeftOverSCU(loscuNIP27,acl32);
%leftover SC at R13 for f34
partialeqscl15=rtcminconv(sclNI,sclRouter);
partialeqscu15=rtcminconv(scuNI,scuRouter);
oacla13P8=OutputACL(partialeqscl15,partialeqscu15,acl15);
oacua13P8=OutputACU(partialeqscl15,partialeqscu15,acu15);
loscla13P36=LeftOverSCL(sclRouter,oacua13P8);
loscua13P36=LeftOverSCU(scuRouter,oacla13P8);
%leftover SC at R14 for f34
oaclb14P16=OutputACL(sclNI,scuNI,acl23);
oacub14P16=OutputACU(sclNI,scuNI,acu23);
loscla14P36=LeftOverSCL(sclRouter,oacub14P16);
loscua14P36=LeftOverSCU(scuRouter,oaclb14P16);
%leftover SC at R12 for f34
oaclb12P29=OutputACL(losclNIP29,loscuNIP29,acl37);
oacub12P29=OutputACU(losclNIP29,loscuNIP29,acu37);
loscla12P36=LeftOverSCL(sclRouter,oacub12P29);
loscua12P36=LeftOverSCU(scuRouter,oaclb12P29);
%leftover SC at R8 for f34
partialeqsclP29=rtcminconv(losclNIP29,sclRouter);
partialeqscuP29=rtcminconv(loscuNIP29,scuRouter);
oaclb8P29=OutputACL(partialeqsclP29,partialeqscuP29,acl37);
oacub8P29=OutputACU(partialeqsclP29,partialeqscuP29,acu37);
loscla8P36=LeftOverSCL(loscla8P29,oacub8P29);
loscua8P36=LeftOverSCU(loscua8P29,oaclb8P29);
eqscl34=rtcminconv(losclNIP36,loscla13P36,loscla14P36,loscla12P36,loscla8P36);
eqscu34=rtcminconv(loscuNIP36,loscua13P36,loscua14P36,loscua12P36,loscua8P36);
% veqsclP29=rtcminconv(sclRouter,loscla8P29);
% veqscuP29=rtcminconv(scuRouter,loscua8P29);
% vlosclP36=LeftOverSCL(veqsclP29,oaclb12P29);
% vloscuP36=LeftOverSCU(veqscuP29,oacub12P29);
% eqscl34=rtcminconv(losclNIP36,rtcminconv(loscla13P36,rtcminconv(loscla14P36,vlosclP36)));
% eqscu34=rtcminconv(loscuNIP36,rtcminconv(loscua13P36,rtcminconv(loscua14P36,vloscuP36)));
fprintf('Delay Bound for Priority 36 (Flow 34):%7.3f cycles\n',rtch(acu34,eqscl34));

%P=37,f33(CSP)
acl33=rtcscale(rtcpjdl(100000000,0,0),4096,0);
acu33=rtcscale(rtcpjdu(100000000,0,0),4096,0);
%leftover SC at NI5 for f33
losclNIP37=LeftOverSCL(sclNI,acu13);
loscuNIP37=LeftOverSCU(scuNI,acl13);
%leftover SC at R5 for f33
partialeqscl2=rtcminconv(losclNIP32,sclRouter);
partialeqscu2=rtcminconv(loscuNIP32,scuRouter);
oaclb5P32=OutputACL(partialeqscl2,partialeqscu2,acl2);
oacub5P32=OutputACU(partialeqscl2,partialeqscu2,acu2);
loscla5P37=LeftOverSCL(sclRouter,oacub5P32);
loscua5P37=LeftOverSCU(scuRouter,oaclb5P32);
%leftover SC at R9 for f33
partialeqscl32=rtcminconv(losclNIP27,rtcminconv(sclRouter,sclRouter));
partialeqscu32=rtcminconv(loscuNIP27,rtcminconv(scuRouter,sclRouter));
oaclb9P32=OutputACL(partialeqscl32,partialeqscu32,acl2);
oacub9P32=OutputACU(partialeqscl32,partialeqscu32,acu2);
loscla9P37=LeftOverSCL(sclRouter,oacub9P32);
loscua9P37=LeftOverSCU(scuRouter,oaclb9P32);
eqscl33=rtcminconv(losclNIP37,rtcminconv(loscla5P37,loscla9P37));
eqscu33=rtcminconv(loscuNIP37,rtcminconv(loscua5P37,loscua9P37));
% veqscl2=rtcminconv(sclRouter,sclRouter);
% veqscu2=rtcminconv(scuRouter,scuRouter);
% vlosclP37=LeftOverSCL(veqscl2,oacub5P32);
% vloscuP37=LeftOverSCU(veqscu2,oaclb5P32);
% eqscl33=rtcminconv(losclNIP37,vlosclP37);
% eqscu33=rtcminconv(loscuNIP37,vloscuP37);
fprintf('Delay Bound for Priority 37 (Flow 33):%7.3f cycles\n',rtch(acu33,eqscl33));

%P=38,f36
acl36=rtcscale(rtcpjdl(100000000,0,0),2048,0);
acu36=rtcscale(rtcpjdu(100000000,0,0),2048,0);
%leftover SC at NI8 for f36
losclNIP38=LeftOverSCL(losclNIP30,acu38);
loscuNIP38=LeftOverSCU(loscuNIP30,acl38);
eqscl36=rtcminconv(losclNIP38,rtcminconv(sclRouter,sclRouter));
eqscu36=rtcminconv(loscuNIP38,rtcminconv(scuRouter,scuRouter));
fprintf('Delay Bound for Priority 38 (Flow 36):%7.3f cycles\n',rtch(acu36,eqscl36));
end

function loscl=LeftOverSCL(betal,acu)
    loscl=rtcmaxconv(rtcminus(betal,acu),0);
end

function loscu=LeftOverSCU(betau,acl)
    loscu=rtcmax(rtcmaxdeconv(rtcminus(betau,acl),0),0);
end

function oacl=OutputACL(betal,betau,acl)
    oacl=rtcmin(rtcminconv(rtcmindeconv(acl,betau),betal),betal);
end

function oacu=OutputACU(betal,betau,acu)
    oacu=rtcmin(rtcmindeconv(rtcminconv(acu,betau),betal),betau);
end