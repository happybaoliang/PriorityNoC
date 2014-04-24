function rtcvssim()
times=6;
length=1;
period=6*length;
bufSize=32;
disp('RTC:');
RTC(bufSize,length,period,times);
end

function RTC(bufSize,Length,Period,Times)
FeedbackDelay=0;

buf_r10_f1=bufSize;
buf_r14_f1=bufSize;
buf_r15_f1=bufSize;
buf_r16_f1=bufSize;
buf_r10_f4=bufSize;
buf_r6_f4=bufSize;
buf_r7_f4=bufSize;
buf_r8_f4=bufSize;
buf_r15_f2=bufSize;
buf_r14_f2=bufSize;
buf_r13_f2=bufSize;
buf_r9_f2=bufSize;
buf_r5_f2=bufSize;
buf_r1_f3=bufSize;
buf_r5_f3=bufSize;
buf_r9_f3=bufSize;
buf_r13_f3=bufSize;

linkl=rtcpjdl(1,0,0);
linku=rtcpjdu(1,0,0);

stageu=rtcpjdu(1,0,0);
stagel=rtcpjdl(1,0,0);

Feedback=rtccurve([FeedbackDelay Inf 0]);

acu=rtcscale(rtcpjdu(Period,0,0),Length,0);
acl=rtcscale(rtcpjdl(Period,0,0),Length,0);

first3stagesl=rtcminconv(rtcminconv(stagel,stagel),stagel);
first3stagesu=rtcminconv(rtcminconv(stageu,stageu),stageu);

scl=rtcminconv(rtcminconv(first3stagesl,stagel),stagel);
scu=rtcminconv(rtcminconv(first3stagesu,stageu),stageu);

tau10l4f4=rtcmatminclos(scl,buf_r10_f4,Times);
tau10u4f4=rtcmatminclos(scu,buf_r10_f4,Times);
eqsc6l4f4=rtcminconv(scl,tau10l4f4(1));
eqsc6u4f4=rtcminconv(scu,tau10u4f4(1));
tau6l4f4=rtcmatminclos(eqsc6l4f4,buf_r6_f4,Times);
tau6u4f4=rtcmatminclos(eqsc6u4f4,buf_r6_f4,Times);
eqsc7l4f4=rtcminconv(scl,tau6l4f4(1));
eqsc7u4f4=rtcminconv(scu,tau6u4f4(1));
tau7l4f4=rtcmatminclos(eqsc7l4f4,buf_r7_f4,Times);
tau7u4f4=rtcmatminclos(eqsc7u4f4,buf_r7_f4,Times);
eqsc8l4f4=rtcminconv(scl,tau7l4f4(1));
eqsc8u4f4=rtcminconv(scu,tau7u4f4(1));
tau8l4f4=rtcmatminclos(eqsc8l4f4,buf_r8_f4,Times);
tau8u4f4=rtcmatminclos(eqsc8u4f4,buf_r8_f4,Times);
eqscl=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau8l4f4(1)),scl),tau7l4f4(1)),scl),tau6l4f4(1)),scl),tau10l4f4(1)),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linku,tau8u4f4(1)),scu),tau7u4f4(1)),scu),tau6u4f4(1)),scu),tau10u4f4(1)),first3stagesu);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,eqscu),eqscl),eqscu);
outacl=rtcmin(rtcminconv(rtcmindeconv(acl,eqscu),eqscl),eqscl);

eqscl4f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau8l4f4(1)),scl),tau7l4f4(1)),scl),tau6l4f4(1)),scl),tau10l4f4(1)),scl);

leftstagel=rtcmaxconv(rtcminus(stagel,outacu),0);
leftstageu=rtcmax(rtcmaxdeconv(rtcminus(stageu,outacl),0),0);

leftscl=rtcminconv(rtcminconv(first3stagesl,leftstagel),linkl);
leftscu=rtcminconv(rtcminconv(first3stagesu,leftstageu),linku);

tau10l4f1=rtcmatminclos(leftscl,buf_r10_f1,Times);
tau10u4f1=rtcmatminclos(leftscu,buf_r10_f1,Times);
eqsc14l4f1=rtcminconv(scl,tau10l4f1(1));
eqsc14u4f1=rtcminconv(scu,tau10u4f1(1));
tau14l4f1=rtcmatminclos(eqsc14l4f1,buf_r14_f1,Times);
tau14u4f1=rtcmatminclos(eqsc14u4f1,buf_r14_f1,Times);
eqsc15l4f1=rtcminconv(scl,tau14l4f1(1));
eqsc15u4f1=rtcminconv(scu,tau14u4f1(1));
tau15l4f1=rtcmatminclos(eqsc15l4f1,buf_r15_f1,Times);
tau15u4f1=rtcmatminclos(eqsc15u4f1,buf_r15_f1,Times);
eqsc16l4f1=rtcminconv(scl,tau15l4f1(1));
eqsc16u4f1=rtcminconv(scu,tau15u4f1(1));
tau16l4f1=rtcmatminclos(eqsc16l4f1,buf_r16_f1,Times);
tau16u4f1=rtcmatminclos(eqsc16u4f1,buf_r16_f1,Times);
eqscl=rtcminconv(rtcminconv(linkl,tau16l4f1(1)),scl);
eqscu=rtcminconv(rtcminconv(linku,tau16u4f1(1)),scu);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,eqscu),eqscl),eqscu);
outacl=rtcmin(rtcminconv(rtcmindeconv(acl,eqscu),eqscl),eqscl);

eqscl4f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau16l4f1(1)),scl),tau15l4f1(1)),scl),tau14l4f1(1)),scl),tau10l4f1(1)),leftscl);

leftstagel=rtcmaxconv(rtcminus(stagel,outacu),0);
leftstageu=rtcmax(rtcmaxdeconv(rtcminus(stageu,outacl),0),0);

leftscl=rtcminconv(rtcminconv(first3stagesl,leftstagel),linkl);
leftscu=rtcminconv(rtcminconv(first3stagesu,leftstageu),linku);

tau5l4f2=rtcmatminclos(scl,buf_r5_f2,Times);
tau5u4f2=rtcmatminclos(scu,buf_r5_f2,Times);
eqsc9l4f2=rtcminconv(scl,tau5l4f2(1));
eqsc9u4f2=rtcminconv(scu,tau5u4f2(1));
tau9l4f2=rtcmatminclos(eqsc9l4f2,buf_r9_f2,Times);
tau9u4f2=rtcmatminclos(eqsc9u4f2,buf_r9_f2,Times);
eqsc13l4f2=rtcminconv(scl,tau9l4f2(1));
eqsc13u4f2=rtcminconv(scu,tau9u4f2(1));
tau13l4f2=rtcmatminclos(eqsc13l4f2,buf_r13_f2,Times);
tau13u4f2=rtcmatminclos(eqsc13u4f2,buf_r13_f2,Times);
eqsc14l4f2=rtcminconv(scl,tau13l4f2(1));
eqsc14u4f2=rtcminconv(scu,tau13u4f2(1));
tau14l4f2=rtcmatminclos(eqsc14l4f2,buf_r14_f2,Times);
tau14u4f2=rtcmatminclos(eqsc14u4f2,buf_r14_f2,Times);
eqsc15l4f2=rtcminconv(leftscl,tau14l4f2(1));
eqsc15u4f2=rtcminconv(leftscu,tau14u4f2(1));
tau15l4f2=rtcmatminclos(eqsc15l4f2,buf_r15_f2,Times);
tau15u4f2=rtcmatminclos(eqsc15u4f2,buf_r15_f2,Times);
eqscl=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau15l4f2(1)),leftscl),tau14l4f2(1)),scl),tau13l4f2(1)),scl),tau9l4f2(1)),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linku,tau15u4f2(1)),leftscu),tau14u4f2(1)),scu),tau13u4f2(1)),scu),tau9u4f2(1)),first3stagesu);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,eqscu),eqscl),eqscu);
outacl=rtcmin(rtcminconv(rtcmindeconv(acl,eqscu),eqscl),eqscl);

eqscl4f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau15l4f2(1)),leftscl),tau14l4f2(1)),scl),tau13l4f2(1)),scl),tau9l4f2(1)),scl),tau9l4f2(1)),scl);

leftstagel=rtcmaxconv(rtcminus(stagel,outacu),0);
leftstageu=rtcmax(rtcmaxdeconv(rtcminus(stageu,outacl),0),0);

leftsclat9=rtcminconv(rtcminconv(first3stagesl,leftstagel),linkl);
leftscuat9=rtcminconv(rtcminconv(first3stagesu,leftstageu),linku);

eqscl=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau15l4f2(1)),leftscl),tau14l4f2(1)),scl),tau13l4f2(1)),first3stagesl);
eqscu=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linku,tau15u4f2(1)),leftscu),tau14u4f2(1)),scu),tau13u4f2(1)),first3stagesu);
outacu=rtcmin(rtcmindeconv(rtcminconv(acu,eqscu),eqscl),eqscu);
outacl=rtcmin(rtcminconv(rtcmindeconv(acl,eqscu),eqscl),eqscl);

leftstagel=rtcmaxconv(rtcminus(stagel,outacu),0);
leftstageu=rtcmax(rtcmaxdeconv(rtcminus(stageu,outacl),0),0);

leftsclat13=rtcminconv(rtcminconv(first3stagesl,leftstagel),linkl);
leftscuat13=rtcminconv(rtcminconv(first3stagesu,leftstageu),linku);

tau1l4f3=rtcmatminclos(scl,buf_r1_f3,Times);
tau1u4f3=rtcmatminclos(scu,buf_r1_f3,Times);
eqsc5l4f3=rtcminconv(scl,tau1l4f3(1));
eqsc5u4f3=rtcminconv(scu,tau1u4f3(1));
tau5l4f3=rtcmatminclos(eqsc5l4f3,buf_r5_f3,Times);
tau5u4f3=rtcmatminclos(eqsc5u4f3,buf_r5_f3,Times);
eqsc9l4f3=rtcminconv(leftsclat9,tau5l4f3(1));
eqsc9u4f3=rtcminconv(leftscuat9,tau5u4f3(1));
tau9l4f3=rtcmatminclos(eqsc9l4f3,buf_r9_f3,Times);
tau9u4f3=rtcmatminclos(eqsc9u4f3,buf_r9_f3,Times);
eqsc13l4f3=rtcminconv(leftsclat13,tau9l4f3(1));
eqsc13u4f3=rtcminconv(leftscuat13,tau9u4f3(1));
tau13l4f3=rtcmatminclos(eqsc13l4f3,buf_r13_f3,Times);
tau13u4f3=rtcmatminclos(eqsc13u4f3,buf_r13_f3,Times);
eqscl4f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(linkl,tau13l4f3(1)),leftsclat13),tau9l4f3(1)),leftsclat9),tau5l4f3(1)),scl),tau1l4f3(1)),scl);
fprintf('Delay Bound for Flow I:%3.3f cycles\n',rtch(acu,eqscl4f1));
fprintf('Delay Bound for Flow II:%3.3f cycles\n',rtch(acu,eqscl4f2));
fprintf('Delay Bound for Flow III:%3.3f cycles\n',rtch(acu,eqscl4f3));
fprintf('Delay Bound for Flow IV:%3.3f cycles\n',rtch(acu,eqscl4f4));
end