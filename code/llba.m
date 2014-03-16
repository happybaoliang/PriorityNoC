L=[4 4 4 4];
J=[0 0 0 0];
%T=[2 2 2 2];
%T=[3 3 3 3];
%T=[4 4 4 4];
%T=[5 5 5 5];
%T=[6 6 6 6];
%T=[7 7 7 7];
%T=[8 8 8 8];
%T=[9 9 9 9];
%T=[10 10 10 10];
%T=[12 12 12 12];
T=[15 15 15 15];
%T=[14 14 14 14];
%T=[16 16 16 16];
%T=[18 18 18 18];
%T=[20 20 20 20];
%T=[22 22 22 22];
%T=[40 40 40 40];

%f4
f4_delay_r8=L(4);
f4_delay_r7=f4_delay_r8;
f4_delay_r6=f4_delay_r7;
f4_delay_r10=L(4);
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
disp(['E2E Latency of f1: ',num2str(f1_delay_r10+J(1)+(4-1))]);
disp(['E2E Latency of f2: ',num2str(f2_delay_r5+J(2)+(5-1))]);
disp(['E2E Latency of f3: ',num2str(f3_delay_r1+J(3)+(4-1))]);
disp(['E2E Latency of f4: ',num2str(f4_delay_r10+J(4)+(4-1))]);


%f4
f4_buf_r8=min(L(4),1);
f4_buf_r7=min(L(4),1);
f4_buf_r6=min(L(4),1);
f4_buf_r10=min(L(4),1);
%f1
f1_buf_r16=min(L(1),1);
f1_buf_r15=min(L(1),1);
f1_buf_r14=min(L(1),1);
f1_buf_r10=min(L(1),ceil((f1_delay_r10+J(4))/T(4))*L(4)+1);
%f2
f2_buf_r15=min(L(2),ceil((f2_delay_r15+J(1)+indirect_jitter_to_f2)/T(1))*L(1)+1);
f2_buf_r14=min(L(2),1);
f2_buf_r13=min(L(2),1);
f2_buf_r9=min(L(2),1);
f2_buf_r5=min(L(2),1);
%f3
f3_buf_r13=min(L(3),ceil((indirect_jitter_to_f3+J(2)+f3_delay_r13)/T(2))*L(2)+1);
f3_buf_r9=min(L(3),ceil((indirect_jitter_to_f3+J(2)+f3_delay_r9)/T(2))*L(2)+1);
f3_buf_r5=min(L(3),1);
f3_buf_r1=min(L(3),1);
disp('Without self-blocking');
disp(['                      BufSize distribution of f1: ',num2str(f1_buf_r16),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r10)]);
disp(['                      BufSize distribution of f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);
disp(['                      BufSize distribution of f3: ',num2str(f3_buf_r13),' , ',num2str(f3_buf_r9),' , ',num2str(f3_buf_r5),' , ',num2str(f3_buf_r1)]);
disp(['                      BufSize distribution of f4: ',num2str(f4_buf_r8),' , ',num2str(f4_buf_r7),' , ',num2str(f4_buf_r6),' , ',num2str(f4_buf_r10)]);


%f4
f4_busy_period_r8=L(4);
newvalue=ceil((f4_busy_period_r8+J(4))/T(4))*L(4);
while(f4_busy_period_r8~=newvalue)
    f4_busy_period_r8=newvalue;
    newvalue=ceil((f4_busy_period_r8+J(4))/T(4))*L(4);
end
f4_num_pkt_r8=ceil((f4_busy_period_r8+J(4))/T(4));
f4_buf_r8=min(f4_num_pkt_r8*L(4),1);
f4_busy_period_r7=L(4);
newvalue=ceil((f4_busy_period_r7+J(4))/T(4))*L(4);
while(f4_busy_period_r7~=newvalue)
    f4_busy_period_r7=newvalue;
    newvalue=ceil((f4_busy_period_r7+J(4))/T(4))*L(4);
end
f4_num_pkt_r7=ceil((f4_busy_period_r7+J(4))/T(4));
f4_buf_r7=min(f4_num_pkt_r7*L(4),1);
f4_busy_period_r6=L(4);
newvalue=ceil((f4_busy_period_r6+J(4))/T(4))*L(4);
while(f4_busy_period_r6~=newvalue)
    f4_busy_period_r6=newvalue;
    newvalue=ceil((f4_busy_period_r6+J(4))/T(4))*L(4);
end
f4_num_pkt_r6=ceil((f4_busy_period_r6+J(4))/T(4));
f4_buf_r6=min(f4_num_pkt_r6*L(4),1);
f4_busy_period_r10=L(4);
newvalue=ceil((f4_busy_period_r10+J(4))/T(4))*L(4);
while(f4_busy_period_r10~=newvalue)
    f4_busy_period_r10=newvalue;
    newvalue=ceil((f4_busy_period_r10+J(4))/T(4))*L(4);
end
f4_num_pkt_r10=ceil((f4_busy_period_r10+J(4))/T(4));
f4_buf_r10=min(f4_num_pkt_r10*L(4),1);
%f1
f1_busy_period_r16=L(1);
newvalue=ceil((f1_busy_period_r16+J(1))/T(1))*L(1);
while(f1_busy_period_r16~=newvalue)
    f1_busy_period_r16=newvalue;
    newvalue=ceil((f1_busy_period_r16+J(1))/T(1))*L(1);
end
f1_num_pkt_r16=ceil((f1_busy_period_r16+J(1))/T(1));
f1_buf_r16=min(f1_num_pkt_r16*L(1),1);
f1_busy_period_r15=L(1);
newvalue=ceil((f1_busy_period_r15+J(1))/T(1))*L(1);
while(f1_busy_period_r15~=newvalue)
    f1_busy_period_r15=newvalue;
    newvalue=ceil((f1_busy_period_r15+J(1))/T(1))*L(1);
end
f1_num_pkt_r15=ceil((f1_busy_period_r15+J(1))/T(1));
f1_buf_r15=min(f1_num_pkt_r15*L(1),1);
f1_busy_period_r14=L(1);
newvalue=ceil((f1_busy_period_r14+J(1))/T(1))*L(1);
while(f1_busy_period_r14~=newvalue)
    f1_busy_period_r14=newvalue;
    newvalue=ceil((f1_busy_period_r14+J(1))/T(1))*L(1);
end
f1_num_pkt_r14=ceil((f1_busy_period_r14+J(1))/T(1));
f1_buf_r14=min(f1_num_pkt_r14*L(1),1);
f1_busy_period_r10=L(1);
newvalue=ceil((f1_busy_period_r10+J(1))/T(1))*L(1)+ceil((f1_busy_period_r10+J(4))/T(4))*L(4);
while(f1_busy_period_r10~=newvalue)
    f1_busy_period_r10=newvalue;
    newvalue=ceil((f1_busy_period_r10+J(1))/T(1))*L(1)+ceil((f1_busy_period_r10+J(4))/T(4))*L(4);
end
f1_num_pkt_r10=ceil((f1_busy_period_r10+J(1))/T(1));
f1_buf_r10=min(f1_num_pkt_r10*L(1),ceil((f1_busy_period_r10+J(4))/T(4))*L(4)+1);
%f2
f2_busy_period_r15=L(2);
newvalue=ceil((f2_busy_period_r15+J(2))/T(2))*L(2)+ceil((f2_busy_period_r15+indirect_jitter_to_f2+J(1))/T(1))*L(1);
while(f2_busy_period_r15~=newvalue)
    f2_busy_period_r15=newvalue;
    newvalue=ceil((f2_busy_period_r15+J(2))/T(2))*L(2)+ceil((f2_busy_period_r15+indirect_jitter_to_f2+J(1))/T(1))*L(1);
end
f2_num_pkt_r15=ceil((f2_busy_period_r15+J(2))/T(2));
f2_buf_r15=min(f2_num_pkt_r15*L(2),ceil((f2_busy_period_r15+J(1)+indirect_jitter_to_f2)/T(1))*L(1)+1);
f2_busy_period_r14=L(2);
newvalue=ceil((f2_busy_period_r14+1)/T(2))*L(2);
while(f2_busy_period_r14~=newvalue)
    f2_busy_period_r14=newvalue;
    newvalue=ceil((f2_busy_period_r14+J(2))/T(2))*L(2);
end
f2_num_pkt_r14=ceil((f2_busy_period_r14+J(2))/T(2));
f2_buf_r14=min((f2_num_pkt_r14+J(2))*L(2),1);
f2_busy_period_r13=L(2);
newvalue=ceil((f2_busy_period_r13+J(2))/T(2))*L(2);
while(f2_busy_period_r13~=newvalue)
    f2_busy_period_r13=newvalue;
    newvalue=ceil((f2_busy_period_r13+J(2))/T(2))*L(2);
end
f2_num_pkt_r13=ceil((f2_busy_period_r13+J(2))/T(2));
f2_buf_r13=min(f2_num_pkt_r13*L(2),1);
f2_busy_period_r9=L(2);
newvalue=ceil((f2_busy_period_r9+J(2))/T(2))*L(2);
while(f2_busy_period_r9~=newvalue)
    f2_busy_period_r9=newvalue;
    newvalue=ceil((f2_busy_period_r9+J(2))/T(2))*L(2);
end
f2_num_pkt_r9=ceil((f2_busy_period_r9+J(2))/T(2));
f2_buf_r9=min(f2_num_pkt_r9*L(2),1);
f2_busy_period_r5=L(2);
newvalue=ceil((f2_busy_period_r5+J(2))/T(2))*L(2);
while(f2_busy_period_r5~=newvalue)
    f2_busy_period_r5=newvalue;
    newvalue=ceil((f2_busy_period_r5+J(2))/T(2))*L(2);
end
f2_num_pkt_r5=ceil((f2_busy_period_r5+J(2))/T(2));
f2_buf_r5=min(f2_num_pkt_r5*L(2),1);
%f3
f3_busy_period_r13=L(3);
newvalue=ceil((f3_busy_period_r13+J(3))/T(3))*L(3)+ceil((f3_busy_period_r13+indirect_jitter_to_f3+J(2))/T(2))*L(2);
while(f3_busy_period_r13~=newvalue)
    f3_busy_period_r13=newvalue;
    newvalue=ceil((f3_busy_period_r13+J(3))/T(3))*L(3)+ceil((f3_busy_period_r13+indirect_jitter_to_f3+J(2))/T(2))*L(2);
end
f3_num_pkt_r13=ceil((f3_busy_period_r13+J(3))/T(3));
f3_buf_r13=min(f3_num_pkt_r13*L(3),ceil((f3_busy_period_r13+J(2)+indirect_jitter_to_f3)/T(2))*L(2)+1);
f3_busy_period_r9=L(3);
newvalue=ceil((f3_busy_period_r9+J(3))/T(3))*L(3)+ceil((f3_busy_period_r9+indirect_jitter_to_f3+J(2))/T(2))*L(2);
while(f3_busy_period_r9~=newvalue)
    f3_busy_period_r9=newvalue;
    newvalue=ceil((f3_busy_period_r9+J(3))/T(3))*L(3)+ceil((f3_busy_period_r9+indirect_jitter_to_f3+J(2))/T(2))*L(2);
end
f3_num_pkt_r9=ceil((f3_busy_period_r9+J(3))/T(3));
f3_buf_r9=min(f3_num_pkt_r9*L(3),ceil((f3_busy_period_r9+J(2)+indirect_jitter_to_f3)/T(2))*L(2)+1);
f3_busy_period_r5=L(3);
newvalue=ceil((f3_busy_period_r5+J(3))/T(3))*L(3);
while(f3_busy_period_r5~=newvalue)
    f3_busy_period_r5=newvalue;
    newvalue=ceil((f3_busy_period_r5+J(3))/T(3))*L(3);
end
f3_num_pkt_r5=ceil((f3_busy_period_r5+J(3))/T(3));
f3_buf_r5=min(f3_num_pkt_r5*L(3),1);
f3_busy_period_r1=L(3);
newvalue=ceil((f3_busy_period_r1+J(3))/T(3))*L(3);
while(f3_busy_period_r1~=newvalue)
    f3_busy_period_r1=newvalue;
    newvalue=ceil((f3_busy_period_r1+J(3))/T(3))*L(3);
end
f3_num_pkt_r1=ceil((f3_busy_period_r1+J(3))/T(3));
f3_buf_r1=min(f3_num_pkt_r1*L(3),1);
disp('With self-blocking');
disp(['                      BufSize distribution of f1: ',num2str(f1_buf_r16),' , ',num2str(f1_buf_r15),' , ',num2str(f1_buf_r14),' , ',num2str(f1_buf_r10)]);
disp(['                      BufSize distribution of f2: ',num2str(f2_buf_r15),' , ',num2str(f2_buf_r14),' , ',num2str(f2_buf_r13),' , ',num2str(f2_buf_r9),' , ',num2str(f2_buf_r5)]);
disp(['                      BufSize distribution of f3: ',num2str(f3_buf_r13),' , ',num2str(f3_buf_r9),' , ',num2str(f3_buf_r5),' , ',num2str(f3_buf_r1)]);
disp(['                      BufSize distribution of f4: ',num2str(f4_buf_r8),' , ',num2str(f4_buf_r7),' , ',num2str(f4_buf_r6),' , ',num2str(f4_buf_r10)]);
