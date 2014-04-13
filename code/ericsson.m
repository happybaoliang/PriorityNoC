function ericsson()
stagel=rtcpjdl(1,0,0);
stageu=rtcpjdu(1,0,0);
stageu1_3=rtcceil(rtcscale(stageu,1/3,0));
stagel1_3=rtcfloor(rtcscale(stagel,1/3,0));
stageu1_4=rtcceil(rtcscale(stageu,1/4,0));
stagel1_4=rtcfloor(rtcscale(stagel,1/4,0));
stageuhalf=rtcceil(rtcscale(stageu,0.5,0));
stagelhalf=rtcfloor(rtcscale(stagel,0.5,0));
scl=conv(stagel,stagel,stagel,stagel,stagel);
scu=conv(stageu,stageu,stageu,stageu,stageu);
sclhalf=conv(stagel,stagel,stagel,stagelhalf,stagel);
scuhalf=conv(stageu,stageu,stageu,stageuhalf,stageu);
first3stagesl=rtcminconv(rtcminconv(stagel,stagel),stagel);
first3stagesu=rtcminconv(rtcminconv(stageu,stageu),stageu);

%flows without any contention
acu09_13=rtcpjdu(125,0,0);
disp(['09->13: ' num2str(rtch(acu09_13,rtcminconv(scl,scl)))]);
acu10_14=rtcpjdu(125,0,0);
disp(['10->14: ' num2str(rtch(acu10_14,rtcminconv(scl,scl)))]);
acu11_15=rtcpjdu(125,0,0);
disp(['11->15: ' num2str(rtch(acu11_15,rtcminconv(scl,scl)))]);
acu16_12=rtcpjdu(32,0,0);
disp(['16->12: ' num2str(rtch(acu16_12,rtcminconv(scl,scl)))]);

%2-4
acu02_04=rtcpjdu(500,0,0);
acl02_04=rtcpjdl(500,0,0);
disp(['02->04: ' num2str(rtch(acu02_04,rtcminconv(rtcminconv(scl,sclhalf),sclhalf)))]);

%3-4
acu03_04=rtcpjdu(500,0,0);
acl03_04=rtcpjdl(500,0,0);
disp(['03->04: ' num2str(rtch(acu03_04,rtcminconv(sclhalf,sclhalf)))]);

%4-3
acu04_03=rtcpjdu(500,0,0);
acl04_03=rtcpjdl(500,0,0);
sclhalf=conv(stagelhalf,stagel,stagel,stagel,stagel);
scuhalf=conv(stageuhalf,stageu,stageu,stageu,stageu);
disp(['04->03: ' num2str(rtch(acu04_03,rtcminconv(sclhalf,scl)))]);

%4-2
acu04_02=rtcpjdu(500,0,0);
acl04_02=rtcpjdl(500,0,0);
disp(['04->02: ' num2str(rtch(acu04_02,rtcminconv(rtcminconv(sclhalf,scl),scl)))]);

%13-16
acu13_09=rtcpjdu(125,0,0);
acl13_09=rtcpjdl(125,0,0);
acu13_16=rtcpjdu(125,0,0);
acl13_16=rtcpjdl(125,0,0);
leftstagel=leftoverscl(acu13_09,stagel);
leftstageu=leftoverscu(acl13_09,stageu);
leftsclat13=conv(leftstagel,stagel,stagel,stagel,stagel);
leftscuat13=conv(leftstageu,stageu,stageu,stageu,stageu);
leftsclat14=conv(stagel,stagel,stagel,stagelhalf,stagel);
leftscuat14=conv(stageu,stageu,stageu,stageuhalf,stageu);
leftsclat15=conv(stagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(stageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(rtcminconv(leftsclat13,leftsclat14),leftsclat15),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(leftscuat13,leftscuat14),leftscuat15),first3stagesu);
outputacu13_16=outputacu(acu13_16,eqscl,eqscu);
outputacl13_16=outputacl(acl13_16,eqscl,eqscu);
disp(['13->16: ' num2str(rtch(acu13_16,rtcminconv(rtcminconv(rtcminconv(leftsclat13,leftsclat14),leftsclat15),leftsclat16)))]);


%14-16
acu14_10=rtcpjdu(125,0,0);
acl14_10=rtcpjdl(125,0,0);
acu14_16=rtcpjdu(125,0,0);
acl14_16=rtcpjdl(125,0,0);
leftstagesl=leftoverscl(acu14_10,stagel);
leftstagesu=leftoverscu(acl14_10,stageu);
leftsclat14=conv(leftstagel,stagel,stagel,stagelhalf,stagel);
leftscuat14=conv(leftstageu,stageu,stageu,stageuhalf,stageu);
leftsclat15=conv(stagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(stageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(leftsclat14,leftsclat15),first3stagesl);
eqscu=rtcminconv(rtcminconv(leftscuat14,leftscuat15),first3stagesu);
outputacu14_16=outputacu(acu14_16,eqscl,eqscu);
outputacl14_16=outputacl(acl14_16,eqscl,eqscu);
disp(['14->16: ' num2str(rtch(acu14_16,rtcminconv(rtcminconv(leftsclat14,leftsclat15),leftsclat16)))]);

%15-16
acu15_11=rtcpjdu(125,0,0);
acl15_11=rtcpjdl(125,0,0);
acu15_16=rtcpjdu(125,0,0);
acl15_16=rtcpjdl(125,0,0);
leftstagel=leftoverscl(acu15_11,stagel);
leftstageu=leftoverscu(acl15_11,stageu);
leftsclat15=conv(leftstagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(leftstageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(leftsclat15,first3stagesl);
eqscu=rtcminconv(leftscuat15,first3stagesu);
outputacu15_16=outputacu(acu15_16,eqscl,eqscu);
outputacl15_16=outputacl(acl15_16,eqscl,eqscu);
disp(['15->16: ' num2str(rtch(acu15_16,rtcminconv(leftsclat15,leftsclat16)))]);

%7-16
acu07_16=rtcpjdu(125,0,0);
acl07_16=rtcpjdl(125,0,0);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(scu,scu),scu),first3stagesu);
outputacu7_16=outputacu(acu07_16,eqscl,eqscu);
outputacl7_16=outputacl(acl07_16,eqscl,eqscu);
disp(['07->16: ' num2str(rtch(acu07_16,rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),leftsclat16)))]);

%aggrassive acu of class C.
aggu=rtcplus(rtcplus(rtcplus(outputacu13_16,outputacu14_16),outputacu15_16),outputacu7_16);
aggl=rtcplus(rtcplus(rtcplus(outputacl13_16,outputacl14_16),outputacl15_16),outputacl7_16);

%leftover sc of 16
leftstagel=leftoverscl(aggu,stagel);
leftstageu=leftoverscu(aggl,stageu);
eqsclat16=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat16=conv(stageu,stageu,stageu,leftstageu,stageu);

%leftover sc of 12
eqscl=rtcminconv(rtcminconv(scl,scl),first3stagesl);
eqscu=rtcminconv(rtcminconv(scu,scu),first3stagesu);
outputacu7_12=outputacu(acu07_16,eqscl,eqscu);
outputacl7_12=outputacl(acl07_16,eqscl,eqscu);
leftscl=leftoverscl(outputacu7_12,stagel);
leftscu=leftoverscu(outputacl7_12,stageu);
eqsclat12=conv(stagel,stagel,stagel,leftscl,stagel);
eqscuat12=conv(stageu,stageu,stageu,leftscu,stageu);

%12_16
acu12_16=rtcpjdu(32,0,0);
acl12_16=rtcpjdl(32,0,0);
disp(['12->16: ' num2str(rtch(acu12_16,rtcminconv(eqsclat12,eqsclat16)))]);

%5-9
acu05_09=rtcpjdu(16,0,0);
acl05_09=rtcpjdl(16,0,0);
eqsclat5=conv(stagel1_3,stagel,stagel,stagel,stagel);
eqscuat5=conv(stageu1_3,stageu,stageu,stageu,stageu);
disp(['05->09: ' num2str(rtch(acu05_09,rtcminconv(eqsclat5,scl)))]);

%leftover sc of 9
eqscl=rtcminconv(eqsclat5,first3stagesl);
eqscu=rtcminconv(eqscuat5,first3stagesu);
outputacu5_9=outputacu(acu05_09,eqscl,eqscu);
outputacl5_9=outputacl(acu05_09,eqscl,eqscu);
leftstagel=leftoverscl(outputacu5_9,stagel);
leftstageu=leftoverscu(outputacl5_9,stageu);
eqsclat9=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat9=conv(stageu,stageu,stageu,leftstageu,stageu);

%13-9
acu13_09=rtcpjdu(125,0,0);
disp(['13->09: ' num2str(rtch(acu13_09,rtcminconv(scl,eqsclat9)))]);

%5-10
acu05_10=rtcpjdu(16,0,0);
acl05_10=rtcpjdl(16,0,0);
eqsclat5=conv(stagel1_3,stagel,stagel,stagelhalf,stagel);
eqscuat5=conv(stageu1_3,stageu,stageu,stageuhalf,stageu);
disp(['05->10: ' num2str(rtch(acu05_10,rtcminconv(rtcminconv(eqsclat5,scl),scl)))]);

%14-10
eqscl=rtcminconv(rtcminconv(eqsclat5,scl),first3stagesl);
eqscu=rtcminconv(rtcminconv(eqscuat5,scu),first3stagesu);
oacu=outputacu(acu05_10,eqscl,eqscu);
oacl=outputacl(acl05_10,eqscl,eqscu);
leftstagel=leftoverscl(oacu,stagel);
leftstageu=leftoverscu(oacl,stageu);
eqsclat10=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat10=conv(stageu,stageu,stageu,leftstageu,stageu);
disp(['14->10: ' num2str(rtch(acu14_10,rtcminconv(scl,eqsclat10)))]);

%5-11
acu05_11=rtcpjdu(16,0,0);
acl05_11=rtcpjdl(16,0,0);
disp(['05->11: ' num2str(rtch(acu05_11,rtcminconv(rtcminconv(rtcminconv(eqsclat5,scl),scl),scl)))]);

%11
eqscl=rtcminconv(rtcminconv(rtcminconv(eqsclat5,scl),scl),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(eqscuat5,scu),scu),first3stagesu);
oacu=outputacu(acu05_11,eqscl,eqscu);
oacl=outputacl(acl05_11,eqscl,eqscu);
leftstagesl=leftoverscl(oacu,stagel);
leftstagesu=leftoverscu(oacl,stageu);
eqsclat11=conv(stagel,stagel,stagel,leftstagesl,stagel);
eqscuat11=conv(stageu,stageu,stageu,leftstagesu,stageu);

%15-11
disp(['15->11: ' num2str(rtch(acu15_11,rtcminconv(eqsclat11,scl)))]);

%12-08
acu12_08=rtcpjdu(125,0,0);
acl12_08=rtcpjdl(125,0,0);
leftstagel=leftoverscl(acu12_16,stagel);
leftstageu=leftoverscu(acl12_16,stageu);
eqscl=conv(leftstagel,stagel,stagel,stagel,stagel);
eqscu=conv(leftstageu,stageu,stageu,stageu,stageu);
disp(['12->08: ' num2str(rtch(acu12_08,rtcminconv(eqscl,scl)))]);

%leftover sc of 5
aggu=rtcplus(rtcplus(acu05_09,acu05_10),acu05_11);
aggl=rtcplus(rtcplus(acl05_09,acl05_10),acl05_11);
leftstagel=rtcfloor(rtcscale(leftoverscl(aggu,stagel),1/3,0));
leftstageu=rtcceil(rtcscale(leftoverscu(aggl,stageu),1/3,0));
stages3l=rtcminconv(rtcminconv(stagel1_3,stagel),stagel);
stages3u=rtcminconv(rtcminconv(stageu1_3,stageu),stageu);
acl=outputacl(acl05_10,stages3l,stages3u);
acu=outputacu(acu05_10,stages3l,stages3u);
leftsl=rtcfloor(rtcscale(leftoverscl(rtcplus(acu,acu),stagel),1/3,0));
leftsu=rtcceil(rtcscale(leftoverscu(rtcplus(acl,acl),stageu),1/3,0));
eqsclat5=conv(leftstagel,stagel,stagel,leftsl,stagel);
eqscuat5=conv(leftstageu,stageu,stageu,leftsu,stageu);

%leftover scl at 2
l=rtcminconv(rtcminconv(sclhalf,scl),first3stagesl);
h=rtcminconv(rtcminconv(scuhalf,scu),first3stagesu);
outacu=outputacu(acu04_02,l,h);
outacl=outputacu(acl04_02,l,h);
eqsclat2=conv(stagel,stagel,stagel,leftoverscl(outacu,stagel),stagel);
eqscuat2=conv(stageu,stageu,stageu,leftoverscu(outacl,stageu),stageu);

%5-2
acu05_02=rtcpjdu(16,0,0);
acl05_02=rtcpjdl(16,0,0);
disp(['05->02: ' num2str(rtch(acu05_02,rtcminconv(rtcminconv(eqsclat5,scl),eqsclat2)))]);

%5-6
acu05_06=rtcpjdu(16,0,0);
acl05_06=rtcpjdl(16,0,0);
disp(['05->06: ' num2str(rtch(acu05_06,rtcminconv(eqsclat5,scl)))]);

%7-6
acu07_06=rtcpjdu(125,0,0);
acl07_06=rtcpjdl(125,0,0);
leftstagel=leftoverscl(acu07_16,stagel);
leftstageu=leftoverscu(acl07_16,stageu);
eqsclat7=conv(leftstagel,stagel,stagel,stagel,stagel);
eqscuat7=conv(leftstageu,stageu,stageu,stageu,stageu);
leftscl4i=rtcminconv(eqsclat5,first3stagesl);
leftscu4i=rtcminconv(eqscuat5,first3stagesu);
oacu=outputacu(acu05_06,leftscl4i,leftscu4i);
oacl=outputacl(acl05_06,leftscl4i,leftscu4i);
leftscl4i=leftoverscl(oacu,stagel);
leftscu4i=leftoverscu(oacl,stageu);
eqsclat6=conv(stagel,stagel,stagel,leftscl4i,stagel);
disp(['07->06: ' num2str(rtch(acu07_06,rtcminconv(eqsclat7,eqsclat6)))]);

%5-3
eqscl=rtcminconv(sclhalf,first3stagesl);
eqscu=rtcminconv(scuhalf,first3stagesu);
oacu=outputacu(acu04_03,eqscl,eqscu);
oacl=outputacl(acl04_03,eqscl,eqscu);
leftstagel=leftoverscl(oacu,stagel);
leftstageu=leftoverscu(oacl,stageu);
eqsclat3=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat3=conv(stageu,stageu,stageu,leftstageu,stageu);
l=rtcminconv(conv(stagel1_3,stagel,stagel,stagelhalf,stagel),first3stagesl);
u=rtcminconv(conv(stageu1_3,stageu,stageu,stageuhalf,stageu),first3stagesu);
oacl=outputacl(acl05_11,l,u);
oacu=outputacu(acu05_11,l,u);
l=leftoverscl(oacu,stagel);
u=leftoverscu(oacl,stageu);
eqsclat6=conv(stagel,stagel,stagel,l,stagel);
eqscuat6=conv(stageu,stageu,stageu,u,stageu);
acu05_03=rtcpjdu(16,0,0);
acl05_03=rtcpjdl(16,0,0);
disp(['05->03: ' num2str(rtch(acu05_03,rtcminconv(rtcminconv(rtcminconv(eqsclat5,eqsclat6),scl),eqsclat3)))]);

%4-8
acu04_08=rtcpjdu(256,0,0);
acl04_08=rtcpjdl(256,0,0);
sumacu=rtcplus(acu04_02,acu04_03);
sumacl=rtcplus(acl04_02,acl04_03);
leftstagelat4=leftoverscl(sumacu,stagel);
leftstageuat4=leftoverscu(sumacl,stageu);
eqsclat4=conv(leftstagelat4,stagel,stagel,stagel,stagel);
eqscuat4=conv(leftstageuat4,stageu,stageu,stageu,stageu);
leftstagelat12=leftoverscl(acu12_16,stagel);
leftstageuat12=leftoverscu(acl12_16,stageu);
leftsclat12=conv(leftstagelat12,stagel,stagel,stagel,stagel);
leftscuat12=conv(leftstageuat12,stageu,stageu,stageu,stageu);
leftstagelat8=rtcminconv(leftsclat12,first3stagesl);
leftstageuat8=rtcminconv(leftscuat12,first3stagesu);
outacu=outputacu(acu12_08,leftstagelat8,leftstageuat8);
outacl=outputacl(acl12_08,leftstagelat8,leftstageuat8);
eqsclat8=conv(stagel,stagel,stagel,leftoverscl(outacu,stagel),stagel);
eqscuat8=conv(stageu,stageu,stageu,leftoverscu(outacl,stageu),stageu);
disp(['04->08: ' num2str(rtch(acu04_08,rtcminconv(eqsclat4,eqsclat8)))]);

%6-7
acu06_07=rtcpjdu(125,0,0);
acl06_07=rtcpjdl(125,0,0);
l=rtcminconv(eqsclat5,first3stagesl);
h=rtcminconv(eqscuat5,first3stagesu);
oacuh=outputacu(acu05_03,l,h);
oaclh=outputacu(acl05_03,l,h);
l=rtcminconv(conv(stagel1_3,stagel,stagel,stagelhalf,stagel),first3stagesl);
h=rtcminconv(conv(stageu1_3,stageu,stageu,stageuhalf,stageu),first3stagesu);
oacua=outputacu(acu05_11,l,h);
oacla=outputacu(acl05_11,l,h);
leftstagel=leftoverscl(rtcplus(oacuh,oacua),stagel);
leftstageu=leftoverscu(rtcplus(oaclh,oacla),stageu);
eqsclat6=conv(stagel,stagel,stagel,leftstagel,stagel);
disp(['06->07: ' num2str(rtch(acu06_07,rtcminconv(eqsclat6,scl)))]);
end

function oacu=outputacu(acu,scl,scu)
    oacu=rtcmin(rtcmindeconv(rtcminconv(acu,scu),scl),scu);
end

function oacu=outputacl(acl,scl,scu)
    oacu=rtcmin(rtcminconv(rtcmindeconv(acl,scu),scl),scl);
end

function scu=leftoverscl(acu,scl)
    scu=rtcmaxconv(rtcminus(scl,acu),0);
end

function scl=leftoverscu(acl,scu)
    scl=rtcmax(rtcmaxdeconv(rtcminus(scu,acl),0),0);
end

function r=conv(sc1,sc2,sc3,sc4,sc5)
    r=rtcminconv(rtcminconv(rtcminconv(rtcminconv(sc1,sc2),sc3),sc4),sc5);
end