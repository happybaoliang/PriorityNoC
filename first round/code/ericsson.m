function ericsson()
linkl=rtcpjdl(1,0,0);
linku=rtcpjdu(1,0,0);
stagel=rtcpjdl(1,0,0);
stageu=rtcpjdu(1,0,0);
linkl1_2=rtcfloor(rtcscale(linkl,0.5,0));
linku1_2=rtcceil(rtcscale(linku,0.5,0));
linkl1_3=rtcfloor(rtcscale(linkl,1/3,0));
linku1_3=rtcceil(rtcscale(linku,1/3,0));
stageu1_2=rtcceil(rtcscale(stageu,0.5,0));
stagel1_2=rtcfloor(rtcscale(stagel,0.5,0));
stageu1_3=rtcceil(rtcscale(stageu,1/3,0));
stagel1_3=rtcfloor(rtcscale(stagel,1/3,0));
stageu1_4=rtcceil(rtcscale(stageu,1/4,0));
stagel1_4=rtcfloor(rtcscale(stagel,1/4,0));

scl=conv(stagel,stagel,stagel,stagel,stagel);
scu=conv(stageu,stageu,stageu,stageu,stageu);
sclhalf=conv(stagel,stagel,stagel,stagel1_2,stagel);
scuhalf=conv(stageu,stageu,stageu,stageu1_2,stageu);
first3stagesl=rtcminconv(rtcminconv(stagel,stagel),stagel);
first3stagesu=rtcminconv(rtcminconv(stageu,stageu),stageu);

%flows without any contention
acu09_13=rtcpjdu(125,0,0);
eqscl0913=rtcminconv(rtcminconv(linkl,scl),scl);
disp(['09->13: ' num2str(rtch(acu09_13,eqscl0913))]);

acu10_14=rtcpjdu(125,0,0);
eqscl1014=rtcminconv(rtcminconv(linkl,scl),scl);
disp(['10->14: ' num2str(rtch(acu10_14,eqscl1014))]);

acu11_15=rtcpjdu(125,0,0);
eqscl1115=rtcminconv(rtcminconv(linkl,scl),scl);
disp(['11->15: ' num2str(rtch(acu11_15,eqscl1115))]);

acu16_12=rtcpjdu(32,0,0);
eqscl1612=rtcminconv(rtcminconv(linkl,scl),scl);
disp(['16->12: ' num2str(rtch(acu16_12,eqscl1612))]);

%2-4
acu02_04=rtcpjdu(500,0,0);
acl02_04=rtcpjdl(500,0,0);
eqscl0204=rtcminconv(rtcminconv(linkl,scl),rtcminconv(sclhalf,sclhalf));
disp(['02->04: ' num2str(rtch(acu02_04,eqscl0204))]);

%3-4
acu03_04=rtcpjdu(500,0,0);
acl03_04=rtcpjdl(500,0,0);
eqscl0304=rtcminconv(rtcminconv(linkl,sclhalf),sclhalf);
disp(['03->04: ' num2str(rtch(acu03_04,eqscl0304))]);

%4-3
acu04_03=rtcpjdu(500,0,0);
acl04_03=rtcpjdl(500,0,0);
eqscl0403=rtcminconv(rtcminconv(linkl1_2,sclhalf),scl);
eqscu0403=rtcminconv(rtcminconv(linku1_2,scuhalf),scu);
disp(['04->03: ' num2str(rtch(acu04_03,eqscl0403))]);

%4-2
acu04_02=rtcpjdu(500,0,0);
acl04_02=rtcpjdl(500,0,0);
eqscl0402=rtcminconv(rtcminconv(linkl1_2,sclhalf),rtcminconv(scl,scl));
eqscu0402=rtcminconv(rtcminconv(linku1_2,scuhalf),rtcminconv(scu,scu));
disp(['04->02: ' num2str(rtch(acu04_02,eqscl0402))]);

%13-16
acu13_09=rtcpjdu(125,0,0);
acl13_09=rtcpjdl(125,0,0);
acu13_16=rtcpjdu(125,0,0);
acl13_16=rtcpjdl(125,0,0);
leftlinkl=leftoverscl(acu13_09,linkl);
leftlinku=leftoverscu(acl13_09,linku);
leftsclat14=conv(stagel,stagel,stagel,stagel1_2,stagel);
leftscuat14=conv(stageu,stageu,stageu,stageu1_2,stageu);
leftsclat15=conv(stagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(stageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);

eqscl=rtcminconv(rtcminconv(rtcminconv(leftlinkl,scl),rtcminconv(leftsclat14,leftsclat15)),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(leftlinku,scu),rtcminconv(leftscuat14,leftscuat15)),first3stagesu);
outputacu13_16=outputacu(acu13_16,eqscl,eqscu);
outputacl13_16=outputacl(acl13_16,eqscl,eqscu);
eqscl=rtcminconv(rtcminconv(rtcminconv(leftlinkl,scl),rtcminconv(leftsclat14,leftsclat15)),leftsclat16);
eqscu=rtcminconv(rtcminconv(rtcminconv(leftlinku,scu),rtcminconv(leftscuat14,leftscuat15)),leftscuat16);
disp(['13->16: ' num2str(rtch(acu13_16,eqscl))]);

%14-16
acu14_10=rtcpjdu(125,0,0);
acl14_10=rtcpjdl(125,0,0);
acu14_16=rtcpjdu(125,0,0);
acl14_16=rtcpjdl(125,0,0);
leftlinkl=leftoverscl(acu14_10,linkl);
leftlinku=leftoverscu(acl14_10,linku);
leftsclat15=conv(stagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(stageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(leftlinkl,leftsclat14),rtcminconv(leftsclat15,first3stagesl));
eqscu=rtcminconv(rtcminconv(leftlinku,leftscuat14),rtcminconv(leftscuat15,first3stagesu));
outputacu14_16=outputacu(acu14_16,eqscl,eqscu);
outputacl14_16=outputacl(acl14_16,eqscl,eqscu);
eqscl=rtcminconv(rtcminconv(leftlinkl,leftsclat14),rtcminconv(leftsclat15,leftsclat16));
eqscu=rtcminconv(rtcminconv(leftlinku,leftscuat14),rtcminconv(leftscuat15,leftscuat16));
disp(['14->16: ' num2str(rtch(acu14_16,eqscl))]);

%15-16
acu15_11=rtcpjdu(125,0,0);
acl15_11=rtcpjdl(125,0,0);
acu15_16=rtcpjdu(125,0,0);
acl15_16=rtcpjdl(125,0,0);
leftlinkl=leftoverscl(acu15_11,linkl);
leftlinku=leftoverscu(acl15_11,linku);
leftsclat15=conv(stagel,stagel,stagel,stagel1_3,stagel);
leftscuat15=conv(stageu,stageu,stageu,stageu1_3,stageu);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(leftlinkl,leftsclat15),first3stagesl);
eqscu=rtcminconv(rtcminconv(leftlinku,leftscuat15),first3stagesu);
outputacu15_16=outputacu(acu15_16,eqscl,eqscu);
outputacl15_16=outputacl(acl15_16,eqscl,eqscu);
eqscl=rtcminconv(rtcminconv(leftlinkl,leftsclat15),leftsclat16);
eqscu=rtcminconv(rtcminconv(leftlinku,leftscuat15),leftscuat16);
disp(['15->16: ' num2str(rtch(acu15_16,eqscl))]);

%7-16
acu07_16=rtcpjdu(125,0,0);
acl07_16=rtcpjdl(125,0,0);
leftsclat16=conv(stagel,stagel,stagel,stagel1_4,stagel);
leftscuat16=conv(stageu,stageu,stageu,stageu1_4,stageu);
eqscl=rtcminconv(rtcminconv(rtcminconv(linkl,scl),rtcminconv(scl,scl)),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(linku,scu),rtcminconv(scu,scu)),first3stagesu);
outputacu7_16=outputacu(acu07_16,eqscl,eqscu);
outputacl7_16=outputacl(acl07_16,eqscl,eqscu);
eqscl=rtcminconv(rtcminconv(rtcminconv(linkl,scl),rtcminconv(scl,scl)),leftsclat16);
eqscu=rtcminconv(rtcminconv(rtcminconv(linku,scu),rtcminconv(scu,scu)),leftscuat16);
disp(['07->16: ' num2str(rtch(acu07_16,eqscl))]);

%aggrassive acu of class C.
aggu=rtcplus(rtcplus(rtcplus(outputacu13_16,outputacu14_16),outputacu15_16),outputacu7_16);
aggl=rtcplus(rtcplus(rtcplus(outputacl13_16,outputacl14_16),outputacl15_16),outputacl7_16);

%leftover sc of 16
leftstagel=leftoverscl(aggu,stagel);
leftstageu=leftoverscu(aggl,stageu);
eqsclat16=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat16=conv(stageu,stageu,stageu,leftstageu,stageu);

%leftover sc of 12
eqscl=rtcminconv(rtcminconv(linkl,scl),rtcminconv(scl,first3stagesl));
eqscu=rtcminconv(rtcminconv(linku,scu),rtcminconv(scu,first3stagesu));
outputacu7_12=outputacu(acu07_16,eqscl,eqscu);
outputacl7_12=outputacl(acl07_16,eqscl,eqscu);
leftscl=leftoverscl(outputacu7_12,stagel);
leftscu=leftoverscu(outputacl7_12,stageu);
eqsclat12=conv(stagel,stagel,stagel,leftscl,stagel);
eqscuat12=conv(stageu,stageu,stageu,leftscu,stageu);

%12_16
acu12_16=rtcpjdu(32,0,0);
acl12_16=rtcpjdl(32,0,0);
eqscl=rtcminconv(rtcminconv(linkl,eqsclat12),eqsclat16);
eqscu=rtcminconv(rtcminconv(linku,eqscuat12),eqscuat16);
disp(['12->16: ' num2str(rtch(acu12_16,eqscl))]);

%5-9
acu05_09=rtcpjdu(16,0,0);
acl05_09=rtcpjdl(16,0,0);
eqsclat5=conv(stagel,stagel,stagel,stagel,stagel);
eqscuat5=conv(stagel,stageu,stageu,stageu,stageu);
eqscl=rtcminconv(rtcminconv(linkl1_3,eqsclat5),scl);
eqscu=rtcminconv(rtcminconv(linku1_3,eqscuat5),scu);
disp(['05->09: ' num2str(rtch(acu05_09,eqscl))]);

%leftover sc of 9
eqscl=rtcminconv(rtcminconv(linkl1_3,eqsclat5),first3stagesl);
eqscu=rtcminconv(rtcminconv(linku1_3,eqscuat5),first3stagesu);
outputacu5_9=outputacu(acu05_09,eqscl,eqscu);
outputacl5_9=outputacl(acu05_09,eqscl,eqscu);
leftstagel=leftoverscl(outputacu5_9,stagel);
leftstageu=leftoverscu(outputacl5_9,stageu);
eqsclat9=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat9=conv(stageu,stageu,stageu,leftstageu,stageu);

%13-9
acu13_09=rtcpjdu(125,0,0);
acl13_09=rtcpjdl(125,0,0);
eqscl=rtcminconv(rtcminconv(linkl,scl),eqsclat9);
eqscu=rtcminconv(rtcminconv(linku,scu),eqscuat9);
disp(['13->09: ' num2str(rtch(acu13_09,eqscl))]);

%5-10
acu05_10=rtcpjdu(16,0,0);
acl05_10=rtcpjdl(16,0,0);
eqscl=rtcminconv(rtcminconv(linkl1_3,sclhalf),rtcminconv(scl,scl));
eqscu=rtcminconv(rtcminconv(linku1_3,scuhalf),rtcminconv(scu,scu));
disp(['05->10: ' num2str(rtch(acu05_10,eqscl))]);

%14-10
eqscl=rtcminconv(rtcminconv(linkl1_3,sclhalf),rtcminconv(scl,first3stagesl));
eqscu=rtcminconv(rtcminconv(linku1_3,scuhalf),rtcminconv(scu,first3stagesu));
oacu=outputacu(acu05_10,eqscl,eqscu);
oacl=outputacl(acl05_10,eqscl,eqscu);
leftstagel=leftoverscl(oacu,stagel);
leftstageu=leftoverscu(oacl,stageu);
eqsclat10=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat10=conv(stageu,stageu,stageu,leftstageu,stageu);
eqscl=rtcminconv(rtcminconv(linkl,scl),eqsclat10);
eqscu=rtcminconv(rtcminconv(linku,scu),eqscuat10);
disp(['14->10: ' num2str(rtch(acu14_10,eqscl))]);

%5-11
acu05_11=rtcpjdu(16,0,0);
acl05_11=rtcpjdl(16,0,0);
eqscl=rtcminconv(rtcminconv(rtcminconv(linkl1_3,sclhalf),rtcminconv(scl,scl)),scl);
eqscu=rtcminconv(rtcminconv(rtcminconv(linku1_3,scuhalf),rtcminconv(scu,scu)),scu);
disp(['05->11: ' num2str(rtch(acu05_11,eqscl))]);

%11
eqscl=rtcminconv(rtcminconv(linkl1_3,sclhalf),rtcminconv(rtcminconv(scl,scl),first3stagesl));
eqscu=rtcminconv(rtcminconv(linku1_3,scuhalf),rtcminconv(rtcminconv(scu,scu),first3stagesu));
oacu=outputacu(acu05_11,eqscl,eqscu);
oacl=outputacl(acl05_11,eqscl,eqscu);
leftstagesl=leftoverscl(oacu,stagel);
leftstagesu=leftoverscu(oacl,stageu);
eqsclat11=conv(stagel,stagel,stagel,leftstagesl,stagel);
eqscuat11=conv(stageu,stageu,stageu,leftstagesu,stageu);

%15-11
eqscl=rtcminconv(rtcminconv(linkl,eqsclat11),scl);
disp(['15->11: ' num2str(rtch(acu15_11,eqscl))]);

%12-08
acu12_08=rtcpjdu(125,0,0);
acl12_08=rtcpjdl(125,0,0);
leftlinkl=leftoverscl(acu12_16,linkl);
leftlinku=leftoverscu(acl12_16,linku);
eqscl=rtcminconv(rtcminconv(leftlinkl,scl),scl);
eqscu=rtcminconv(rtcminconv(leftlinku,scu),scu);
disp(['12->08: ' num2str(rtch(acu12_08,eqscl))]);

%leftover sc of 5
aggu=rtcplus(rtcplus(acu05_09,acu05_10),acu05_11);
aggl=rtcplus(rtcplus(acl05_09,acl05_10),acl05_11);
leftlinkl=rtcfloor(rtcscale(leftoverscl(aggu,linkl),1/3,0));
leftlinku=rtcceil(rtcscale(leftoverscu(aggl,linku),1/3,0));

oacl0510=outputacl(acl05_10,rtcminconv(linkl1_3,first3stagesl),rtcminconv(linku1_3,first3stagesu));
oacu0510=outputacu(acu05_10,rtcminconv(linkl1_3,first3stagesl),rtcminconv(linku1_3,first3stagesu));;
leftsl=rtcfloor(rtcscale(leftoverscl(rtcplus(oacu0510,oacu0510),stagel),1/3,0));
leftsu=rtcceil(rtcscale(leftoverscu(rtcplus(oacl0510,oacl0510),stageu),1/3,0));
eqsclat5=conv(stagel,stagel,stagel,leftsl,stagel);
eqscuat5=conv(stageu,stageu,stageu,leftsu,stageu);

%leftover scl at 2
eqscl0402=rtcminconv(rtcminconv(linkl1_2,sclhalf),rtcminconv(scl,first3stagesl));
eqscu0402=rtcminconv(rtcminconv(linku1_2,scuhalf),rtcminconv(scu,first3stagesu));
outacu=outputacu(acu04_02,eqscl0402,eqscu0402);
outacl=outputacu(acl04_02,eqscl0402,eqscu0402);
eqsclat2=conv(stagel,stagel,stagel,leftoverscl(outacu,stagel),stagel);
eqscuat2=conv(stageu,stageu,stageu,leftoverscu(outacl,stageu),stageu);

%5-2
acu05_02=rtcpjdu(16,0,0);
acl05_02=rtcpjdl(16,0,0);
eqscl=rtcminconv(rtcminconv(leftlinkl,eqsclat5),eqsclat2);
eqscu=rtcminconv(rtcminconv(leftlinku,eqscuat5),eqscuat2);
disp(['05->02: ' num2str(rtch(acu05_02,eqscl))]);

%5-6
acu05_06=rtcpjdu(16,0,0);
acl05_06=rtcpjdl(16,0,0);
eqscl=rtcminconv(rtcminconv(leftlinkl,eqsclat5),scl);
eqscu=rtcminconv(rtcminconv(leftlinku,eqscuat5),scu);
disp(['05->06: ' num2str(rtch(acu05_06,eqscl))]);

%5-3
%leftover sc at r3
eqscl=rtcminconv(rtcminconv(linkl1_2,sclhalf),first3stagesl);
eqscu=rtcminconv(rtcminconv(linku1_2,scuhalf),first3stagesu);
oacu=outputacu(acu04_03,eqscl,eqscu);
oacl=outputacl(acl04_03,eqscl,eqscu);
leftstagel=leftoverscl(oacu,stagel);
leftstageu=leftoverscu(oacl,stageu);
eqsclat3=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscuat3=conv(stageu,stageu,stageu,leftstageu,stageu);
%leftover sc at r6
l=rtcminconv(rtcminconv(linkl1_3,sclhalf),first3stagesl);
u=rtcminconv(rtcminconv(linku1_3,scuhalf),first3stagesu);
oacl=outputacl(acl05_11,l,u);
oacu=outputacu(acu05_11,l,u);
l=leftoverscl(oacu,stagel);
u=leftoverscu(oacl,stageu);
eqsclat6=conv(stagel,stagel,stagel,l,stagel);
eqscuat6=conv(stageu,stageu,stageu,u,stageu);
acu05_03=rtcpjdu(16,0,0);
acl05_03=rtcpjdl(16,0,0);
eqscl=rtcminconv(rtcminconv(leftlinkl,eqsclat5),rtcminconv(rtcminconv(eqsclat3,eqsclat6),scl));
eqscu=rtcminconv(rtcminconv(leftlinku,eqscuat5),rtcminconv(rtcminconv(eqscuat3,eqscuat6),scu));
disp(['05->03: ' num2str(rtch(acu05_03,eqscl))]);

%7-6
acu07_06=rtcpjdu(125,0,0);
acl07_06=rtcpjdl(125,0,0);
leftlinksl=leftoverscl(acu07_16,linkl);
leftlinksu=leftoverscu(acl07_16,linku);
eqscl=rtcminconv(rtcminconv(leftlinksl,eqsclat5),first3stagesl);
eqscu=rtcminconv(rtcminconv(leftlinksu,eqscuat5),first3stagesu);
oacu=outputacu(acu05_06,eqscl,eqscu);
oacl=outputacl(acl05_06,eqscl,eqscu);
leftscl4i=leftoverscl(oacu,stagel);
leftscu4i=leftoverscu(oacl,stageu);
eqsclat6=conv(stagel,stagel,stagel,leftscl4i,stagel);
eqscl=rtcminconv(rtcminconv(leftlinksl,scl),eqsclat6);
eqscu=rtcminconv(rtcminconv(leftlinksu,scu),eqscuat6);
disp(['07->06: ' num2str(rtch(acu07_06,eqscl))]);

%4-8
acu04_08=rtcpjdu(256,0,0);
acl04_08=rtcpjdl(256,0,0);
sumacu=rtcplus(acu04_02,acu04_03);
sumacl=rtcplus(acl04_02,acl04_03);
leftlinklat4=leftoverscl(sumacu,linkl);
leftlinkuat4=leftoverscu(sumacl,linku);
leftlinklat12=leftoverscl(acu12_16,linkl);
leftlinkuat12=leftoverscu(acl12_16,linku);
leftstagelat8=rtcminconv(rtcminconv(leftlinklat12,scl),first3stagesl);
leftstageuat8=rtcminconv(rtcminconv(leftlinkuat12,scu),first3stagesu);
outacu=outputacu(acu12_08,leftstagelat8,leftstageuat8);
outacl=outputacl(acl12_08,leftstagelat8,leftstageuat8);
eqsclat8=conv(stagel,stagel,stagel,leftoverscl(outacu,stagel),stagel);
eqscuat8=conv(stageu,stageu,stageu,leftoverscu(outacl,stageu),stageu);
eqscl=rtcminconv(rtcminconv(leftlinklat4,scl),eqsclat8);
eqscu=rtcminconv(rtcminconv(leftlinkuat4,scu),eqscuat8);
disp(['04->08: ' num2str(rtch(acu04_08,eqscl))]);

%6-7
acu06_07=rtcpjdu(125,0,0);
acl06_07=rtcpjdl(125,0,0);
eqscl=rtcminconv(rtcminconv(leftlinkl,eqsclat5),first3stagesl);
eqscu=rtcminconv(rtcminconv(leftlinku,eqscuat5),first3stagesu);
oacuh=outputacu(acu05_03,eqscl,eqscu);
oaclh=outputacu(acl05_03,eqscl,eqscu);
l=rtcminconv(rtcminconv(linkl1_3,sclhalf),first3stagesl);
h=rtcminconv(rtcminconv(linku1_3,scuhalf),first3stagesu);
oacua=outputacu(acu05_11,l,h);
oacla=outputacu(acl05_11,l,h);
leftstagel=leftoverscl(rtcplus(oacuh,oacua),stagel);
leftstageu=leftoverscu(rtcplus(oaclh,oacla),stageu);
eqsclat6=conv(stagel,stagel,stagel,leftstagel,stagel);
eqscl=rtcminconv(rtcminconv(linkl,eqsclat6),scl);
eqscu=rtcminconv(rtcminconv(linku,eqscuat6),scu);
disp(['06->07: ' num2str(rtch(acu06_07,eqscl))]);
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