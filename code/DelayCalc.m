function DelayCalc()
RTC();
DNC();
end

function RTC()
Times=9;
Period=1;
Length=1;
buf_r10_f1=5;
buf_r14_f1=5;
buf_r15_f1=5;
buf_r16_f1=5;
buf_r10_f4=5;
buf_r6_f4=5;
buf_r7_f4=5;
buf_r8_f4=5;
buf_r15_f2=5;
buf_r14_f2=5;
buf_r13_f2=5;
buf_r9_f2=5;
buf_r5_f2=5;
buf_r1_f3=5;
buf_r5_f3=5;
buf_r9_f3=5;
buf_r13_f3=5;
FeedbackDelay=0;

%生成各种曲线
scu_stage1=rtcpjdu(1,0,0);
scl_stage1=rtcpjdl(1,0,0);
scu_stage4=rtcpjdu(1,0,0);
scl_stage4=rtcpjdl(1,0,0);
scu_stage5=rtcpjdu(1,0,0);
scl_stage5=rtcpjdl(1,0,0);
Feedback=rtccurve([FeedbackDelay Inf 0]);
acu=rtcscale(rtcpjdu(Period,0,0),Length,0);
acl=rtcscale(rtcpjdl(Period,0,0),Length,0);
scu_stage2=rtcscale(rtcpjdu(1,0,0),Length,0);
scl_stage2=rtcscale(rtcpjdl(1,0,0),Length,0);
scu_stage3=rtcscale(rtcpjdu(1,0,0),Length,0);
scl_stage3=rtcscale(rtcpjdl(1,0,0),Length,0);

scu=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scu_stage1,scu_stage2),scu_stage3),scu_stage4),scu_stage5);
scl=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),scl_stage4),scl_stage5);

%计算R10为数据流f1和f4提供的服务曲线
%scu_stage4_f4=rtcceil(rtcscale(scu_stage4,0.5,0));
scl_stage4_f4=rtcfloor(rtcscale(scl_stage4,0.5,0));
%scur10_f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scu_stage1,scu_stage2),scu_stage3),scu_stage4_f4),scu_stage5);
sclr10_f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),scl_stage4_f4),scl_stage5);
scu_stage4_f1=rtcceil(rtcscale(scu_stage4,0.5,0));
scl_stage4_f1=rtcfloor(rtcscale(scl_stage4,0.5,0));
scur10_f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scu_stage1,scu_stage2),scu_stage3),scu_stage4_f1),scu_stage5);
sclr10_f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),scl_stage4_f1),scl_stage5);

%计算tau10_f1
tempu_f1=rtcplus(rtcminconv(scur10_f1,Feedback),buf_r10_f1);
templ_f1=rtcplus(rtcminconv(sclr10_f1,Feedback),buf_r10_f1);
%tau10u_f1=rtcmatminclos(tempu_f1,0,Times);
tau10l_f1=rtcmatminclos(templ_f1,0,Times);

%计算tau10_f4
%tempu_f4=rtcplus(rtcminconv(scur10_f4,Feedback),buf_r10_f4);
templ_f4=rtcplus(rtcminconv(sclr10_f4,Feedback),buf_r10_f4);
%tau10u_f4=rtcmatminclos(tempu_f4,0,Times);
tau10l_f4=rtcmatminclos(templ_f4,0,Times);

%计算tau14_f1
tempu_f1=rtcmin(tempu_f1,rtcplus(rtcminconv(scu,Feedback),buf_r14_f1));
templ_f1=rtcmin(templ_f1,rtcplus(rtcminconv(scl,Feedback),buf_r14_f1));
%tau14u_f1=rtcmatminclos(tempu_f1,0,Times);
tau14l_f1=rtcmatminclos(templ_f1,0,Times);

%计算tau6_f4
%tempu_f4=rtcmin(tempu_f4,rtcplus(rtcminconv(scu,Feedback),buf_r6_f4));
templ_f4=rtcmin(templ_f4,rtcplus(rtcminconv(scl,Feedback),buf_r6_f4));
%tau6u_f4=rtcmatminclos(tempu_f4,0,Times);
tau6l_f4=rtcmatminclos(templ_f4,0,Times);

%计算tau15_f1
tempu_f1=rtcmin(tempu_f1,rtcplus(rtcminconv(scu,Feedback),buf_r15_f1));
templ_f1=rtcmin(templ_f1,rtcplus(rtcminconv(scl,Feedback),buf_r15_f1));
tau15u_f1=rtcmatminclos(tempu_f1,0,Times);
tau15l_f1=rtcmatminclos(templ_f1,0,Times);

%计算tau7_f4
%tempu_f4=rtcmin(tempu_f4,rtcplus(rtcminconv(scu,Feedback),buf_r7_f4));
templ_f4=rtcmin(templ_f4,rtcplus(rtcminconv(scl,Feedback),buf_r7_f4));
%tau7u_f4=rtcmatminclos(tempu_f4,0,Times);
tau7l_f4=rtcmatminclos(templ_f4,0,Times);

%计算tau16_f1
tempu_f1=rtcmin(tempu_f1,rtcplus(rtcminconv(scu,Feedback),buf_r16_f1));
templ_f1=rtcmin(templ_f1,rtcplus(rtcminconv(scl,Feedback),buf_r16_f1));
tau16u_f1=rtcmatminclos(tempu_f1,0,Times);
tau16l_f1=rtcmatminclos(templ_f1,0,Times);

%计算tau8_f4
%tempu_f4=rtcmin(tempu_f4,rtcplus(rtcminconv(scu,Feedback),buf_r8_f4));
templ_f4=rtcmin(templ_f4,rtcplus(rtcminconv(scl,Feedback),buf_r8_f4));
%tau8u_f4=rtcmatminclos(tempu_f4,0,Times);
tau8l_f4=rtcmatminclos(templ_f4,0,Times);

%计算网络为数据流f4提供的服务曲线
eqscl_f4=rtcminconv(rtcminconv(rtcminconv(tau8l_f4(1),scl),tau7l_f4(1)),scl);
eqscl_f4=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl_f4,tau6l_f4(1)),scl),tau10l_f4(1)),sclr10_f4);

%计算网络为数据流f1提供的服务曲线
eqscl_f1=rtcminconv(rtcminconv(rtcminconv(tau16l_f1(1),scl),tau15l_f1(1)),scl);
eqscl_f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl_f1,tau14l_f1(1)),scl),tau10l_f1(1)),sclr10_f1);

%计算f1的端到端延迟
Y1=rtch(acu,eqscl_f1);
fprintf('Delay Bound for Flow I:%3.3f cycles\n',Y1);

%为f2计算tau5
tempu_f2=rtcplus(rtcminconv(scu,Feedback),buf_r5_f2);
templ_f2=rtcplus(rtcminconv(scl,Feedback),buf_r5_f2);
%tau5u_f2=rtcmatminclos(tempu_f2,0,Times);
tau5l_f2=rtcmatminclos(templ_f2,0,Times);

%为f2计算tau9
tempu_f2=rtcmin(tempu_f2,rtcplus(rtcminconv(scu,Feedback),buf_r9_f2));
templ_f2=rtcmin(templ_f2,rtcplus(rtcminconv(scl,Feedback),buf_r9_f2));
tau9u_f2=rtcmatminclos(tempu_f2,0,Times);
tau9l_f2=rtcmatminclos(templ_f2,0,Times);

%为f2计算tau13
tempu_f2=rtcmin(tempu_f2,rtcplus(rtcminconv(scu,Feedback),buf_r13_f2));
templ_f2=rtcmin(templ_f2,rtcplus(rtcminconv(scl,Feedback),buf_r13_f2));
%tau13u_f2=rtcmatminclos(tempu_f2,0,Times);
tau13l_f2=rtcmatminclos(templ_f2,0,Times);

%为f2计算tau14
tempu_f2=rtcmin(tempu_f2,rtcplus(rtcminconv(scu,Feedback),buf_r14_f2));
templ_f2=rtcmin(templ_f2,rtcplus(rtcminconv(scl,Feedback),buf_r14_f2));
tau14u_f2=rtcmatminclos(tempu_f2,0,Times);
tau14l_f2=rtcmatminclos(templ_f2,0,Times);

%计算f1在R15处的到达曲线
partialscu_f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(tau16u_f1,scu),tau15u_f1),scu_stage1),scu_stage2),scu_stage3);
partialscl_f1=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(tau16l_f1,scl),tau15l_f1),scl_stage1),scl_stage2),scl_stage3);
outacu_f1=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu_f1),partialscl_f1),partialscu_f1);
outacl_f1=rtcmin(rtcminconv(rtcmindeconv(acl,partialscu_f1),partialscl_f1),partialscl_f1);

%计算R15的剩余服务曲线
leftscu15_f2=rtcmax(rtcmaxdeconv(rtcminus(scu,outacl_f1),0),0);
leftscu15_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scu_stage1,scu_stage2),scu_stage3),leftscu15_f2),scu_stage5);
leftscl15_f2=rtcmaxconv(rtcminus(scl,outacu_f1),0);
leftscl15_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),leftscl15_f2),scl_stage5);

%为f2计算tau15
tempu_f2=rtcmin(tempu_f2,rtcplus(rtcminconv(leftscu15_f2,Feedback),buf_r15_f2));
templ_f2=rtcmin(templ_f2,rtcplus(rtcminconv(leftscl15_f2,Feedback),buf_r15_f2));
tau15u_f2=rtcmatminclos(tempu_f2,0,Times);
tau15l_f2=rtcmatminclos(templ_f2,0,Times);

%计算f2的等效服务曲线
eqscl_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(tau15l_f2(1),leftscl15_f2),tau14l_f2(1)),scl),tau13l_f2(1));
eqscl_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl_f2,scl),tau9l_f2(1)),scl),tau5l_f2(1)),scl);

%计算f2的端到端延迟
Y2=rtch(acu,eqscl_f2);
fprintf('Delay Bound for Flow II:%3.3f cycles\n',Y2);

%为数据流f3计算tau1的下括服务曲线
templ_f3=rtcplus(rtcminconv(scl,Feedback),buf_r1_f3);
tau1l_f3=rtcmatminclos(templ_f3,0,Times);

%为数据流f3计算tau5的下括服务曲线
templ_f3=rtcmin(templ_f3,rtcplus(rtcminconv(scl,Feedback),buf_r5_f3));
tau5l_f3=rtcmatminclos(templ_f3,0,Times);

%计算f2在R13处的到达曲线
partialscu_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(tau15u_f2,leftscu15_f2),tau14u_f2),scu),tau13u_f2(1)),scu_stage1),scu_stage2),scu_stage3);
partialscl_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcmincvon(rtcminconv(tau15l_f2,leftscl15_f2),tau14l_f2),scl),tau13l_f2(1)),scl_stage1),scl_stage2),scl_stage3);
outacu_f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu_f2),partialscl_f2),partialscu_f2);

%计算数据流f2在R13处的下括剩余服务曲线
leftscl13_f3=rtcmaxconv(rtcminus(scl_stage4,outacu_f2),0);
leftscl13_f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),leftscl13_f3),scl_stage5);

%计算tau13的下括服务曲线
templ_f3=rtcmin(templ_f3,rtcplus(rtcminconv(leftscl13_f3,Feedback),buf_r13_f3));
tau13l_f3=rtcmatminclos(templ_f3,0,Times);

%计算f2在R9处的到达曲线
partialscu_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(partialscu_f2,scu),tau9u_f2),scu_stage1),scu_stage2),scu_stage3);
partialscl_f2=rtcminconv(rtcminconv(rtcminconv(rtcminconv(rtcminconv(partialscl_f2,scl),tau9l_f2),scl_stage1),scl_stage2),scl_stage3);
outacu_f2=rtcmin(rtcmindeconv(rtcminconv(acu,partialscu_f2),partialscl_f2),partialscu_f2);

%计算数据流f2在R9处的下括剩余服务曲线
leftscl9_f3=rtcmaxconv(rtcminus(scl_stage4,outacu_f2),0);
leftscl9_f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(scl_stage1,scl_stage2),scl_stage3),leftscl9_f3),scl_stage5);

%计算tau9的服务曲线
templ_f3=rtcmin(templ_f3,rtcplus(rtcminconv(leftscl9_f3,Feedback),buf_r9_f3));
tau9l_f3=rtcmatminclos(templ_f3,0,Times);

%计算数据流f3的等效服务曲线
eqscl_f3=rtcminconv(rtcminconv(rtcminconv(tau13l_f3(1),leftscl13_f3),tau9l_f3(1)),leftscl9_f3);
eqscl_f3=rtcminconv(rtcminconv(rtcminconv(rtcminconv(eqscl_f3,tau5l_f3(1)),scl),tau1l_f3(1)),scl);

%计算f3的端到端延迟
Y3=rtch(acu,eqscl_f3);
fprintf('Delay Bound for Flow III:%3.3f cycles\n',Y3);

%计算f4的端到端延迟
Y4=rtch(acu,eqscl_f4);
fprintf('Delay Bound for Flow IV:%3.3f cycles\n',Y4);
end

function DNC()
end