length=2;
period=6;

scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

acl=rtcscale(rtcpjdl(period,0,0),length,0);
acu=rtcscale(rtcpjdu(period,0,0),length,0);

partialscu4f4=rtcminconv(rtcminconv(scu,scu),scu);
partialscl4f4=rtcminconv(rtcminconv(scl,scl),scl);

eqscl4f4=rtcminconv(partialscl4f4,scl);

outacu4f4=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f4),partialscl4f4),partialscu4f4);
outacl4f4=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f4),partialscl4f4),partialscl4f4);

leftscl4f1=rtcmaxconv(rtcminus(scl,outacu4f4),0);
leftscu4f1=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f4),0),0);

eqscl4f1=rtcminconv(rtcminconv(rtcminconv(scl,scl),scl),leftscl4f1);

outacl=rtcmin(rtcminconv(rtcmindeconv(acl,scu),scl),scl);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,scu),scl),scu);

leftscl4f2=rtcmaxconv(rtcminus(scl,outacu),0);
leftscu4f2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl),0),0);

eqscu4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscu4f2,scu),scu),scu),scu);
eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(leftscl4f2,scl),scl),scl),scl);

partialscu4f2=rtcminconv(leftscu4f2,scu);
partialscl4f2=rtcminconv(leftscl4f2,scl);
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu4f2),partialscl4f2),partialscu4f2);
outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu4f2),partialscl4f2),partialscl4f2);

concscu=rtcminconv(scu,scu);
concscl=rtcminconv(scl,scl);

leftscl4f3=rtcmaxconv(rtcminus(concscl,outacu4f2),0);
leftscu4f3=rtcmax(rtcmaxdeconv(rtcminus(concscu,outacl4f2),0),0);

eqscl4f3=rtcminconv(rtcminconv(leftscl4f3,scl),scl);

disp([rtch(acu,eqscl4f1),rtch(acu,eqscl4f2),rtch(acu,eqscl4f3),rtch(acu,eqscl4f4)])