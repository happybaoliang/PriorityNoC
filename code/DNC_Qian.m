function Y=test(R,B)
C=1;
T=5;
b1=B;
b2=B;
b3=B;
r1=R;
r2=R;
r3=R;

acu=rtccurve([0 b3 r3]);
beta13_f3=rtccurve([[0 0 0];[T+(b2+r2*(2*T+(b1+r1*T)/(C-r1)))/(C-r2) 0 C-r2]]);
beta9_f3=rtccurve([[0 0 0];[T+T+(b2+r2*(3*T+1+(b1+r1*T)/(C-r1)))/(C-r2) 0 C-r2]]);
beta5_f3=rtccurve([[0 0 0];[T 0 C]]);
beta1_f3=rtccurve([[0 0 0];[T 0 C]]);

eqscl=rtcminconv(rtcminconv(rtcminconv(beta13_f3,beta9_f3),beta5_f3),beta1_f3);
Y=rtch(acu,eqscl);
end