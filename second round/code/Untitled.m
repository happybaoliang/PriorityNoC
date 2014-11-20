scu=rtcpjdu(1,0,0);
scl=rtcpjdl(1,0,0);

acl=rtcscale(rtcpjdl(20,0,0),4,0);
acu=rtcscale(rtcpjdu(20,0,0),4,0);

%first approach: take five service elements as a single element
scuRouter=rtcminconv(scu,scu,scu,scu,scu);
sclRouter=rtcminconv(scl,scl,scl,scl,scl);

loscl1a1=rtcmaxconv(rtcminus(sclRouter,acu),0);
loscu1a1=rtcmax(rtcmaxdeconv(rtcminus(scuRouter,acl),0),0);

oacl=rtcmin(rtcminconv(rtcmindeconv(acl,scuRouter),sclRouter),sclRouter);
oacu=rtcmin(rtcmindeconv(rtcminconv(acu,scuRouter),sclRouter),scuRouter);

loscl1a2=rtcmaxconv(rtcminus(sclRouter,oacu),0);
loscu1a2=rtcmax(rtcmaxdeconv(rtcminus(scuRouter,oacl),0),0);

disp(['first approach: ',num2str(rtch(acu,rtcminconv(loscl1a1,loscl1a2)))]);

%second approach: processing these service elements separately
partialscl=rtcminconv(scl,scl,scl,scl);
partialscu=rtcminconv(scu,scu,scu,scu);
oacl=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu),partialscl),partialscl);
oacu=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu),partialscl),partialscu);
loscl=rtcmaxconv(rtcminus(scl,oacu),0);
loscu=rtcmax(rtcmaxdeconv(rtcminus(scu,oacl),0),0);

loscl2a1=rtcminconv(partialscl,loscl);
loscu2a1=rtcminconv(partialscu,loscu);

partialscl=rtcminconv(sclRouter,partialscl);
partialscu=rtcminconv(scuRouter,partialscu);

oacl=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu),partialscl),partialscl);
oacu=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu),partialscl),partialscu);
loscl=rtcmaxconv(rtcminus(scl,oacu),0);
loscu=rtcmax(rtcmaxdeconv(rtcminus(scu,oacl),0),0);

loscl2a2=rtcminconv(partialscl,loscl);
loscu2a2=rtcminconv(partialscu,loscu);

disp(['second approach: ',num2str(rtch(acu,rtcminconv(loscl2a1,loscl2a2)))]);

%third approach: DNC
sclRouter=rtcminconv(scl,scl,scl,scl,scl);
loscla1=rtcmaxconv(rtcminus(sclRouter,acu),0);

oacu=rtcmindeconv(acu,sclRouter);

loscu1a2=rtcmaxconv(rtcminus(sclRouter,oacu),0);

disp(['third approach: ',num2str(rtch(acu,rtcminconv(loscl1a1,loscl1a2)))]);