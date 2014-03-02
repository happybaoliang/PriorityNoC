scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

length=1;
period=length*6;

acl=rtcscale(rtcpjdl(period,0,0),length,0);
acu=rtcscale(rtcpjdu(period,0,0),length,0);

leftscl4f1=rtcfloor(rtcscale(scl,0.5,0));
leftscu4f1=rtcceil(rtcscale(scu,0.5,0));

eqscu4f1=rtcminconv(rtcminconv(rtcminconv(scu,scu),scu),leftscu4f1);
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

% concscu=rtcminconv(scu,scu);
% concscl=rtcminconv(scl,scl);
% 
% leftscl4f3=rtcmaxconv(rtcminus(concscl,outacu4f2),0);
% leftscu4f3=rtcmax(rtcmaxdeconv(rtcminus(concscu,outacl4f2),0),0);
% 
% eqscl4f3=rtcminconv(rtcminconv(leftscl4f3,scl),scl);
leftscl1=rtcmaxconv(rtcminus(scl,outacu4f2),0);
leftscu1=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f2),0),0);

concscu=rtcminconv(partialscu4f2,scu);
concscl=rtcminconv(partialscl4f2,scl);
outacu4f2=rtcmin(rtcmindeconv(rtcminconv(acu,concscu),concscl),concscu);
outacl4f2=rtcmin(rtcminconv(rtcmindeconv(acl,concscu),concscu),concscl);

leftscl2=rtcmaxconv(rtcminus(scl,outacu4f2),0);
leftscu2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl4f2),0),0);

eqscl4f3=rtcminconv(rtcminconv(rtcminconv(leftscl1,leftscl2),scl),scl);

disp([rtch(acu,eqscl4f1),rtch(acu,eqscl4f2),rtch(acu,eqscl4f3),rtch(acu,eqscl4f1)])