function test()
Labelx={'RTC(1/6)' 'DNC(1/6)' 'RTC(1/5)' 'DNC(1/5)' 'RTC(1/4)' 'DNC(1/4)' 'RTC(1/3)' 'DNC(1/3)'};
Labely={'8','7','6','5','4','3','2','1'};
Z=[ 43      63.24       51      67.125     59     73.8889  68      88.5;    %8
    47      59.16       47      62.75      54     69       65      82.5;    %7
    43      55.08       49      58.375     49     64.111   61      76.5;    %6
    39      51          44      54         49     59.222   58      70.5;    %5
    39      46.92       39      49.625     44     54.33    55      64.5;    %4
    34      42.84       37      45.25      44     49.444   52      58.5;    %3
    31      38.76       35      40.875     39     44.556   49      52.5;    %2
    29      34.68       32      36.5       36     39.667   43      46.5];   %1                           
%RTC(1/6)  %DNC(1/6) %RTC(1/5)%DNC(1/5)%RTC(1/4)%DNC(1/4)%RTC(1/3)%DNC(1/3)
hb=bar3(Z);
%colorbar;
set(gca,'xticklabel',Labelx,'FontSize',10);
set(gca,'yticklabel',Labely,'FontSize',10);
xlabel('Injection Rate (flits/cycle)','Rotation',20,'FontSize',12);
ylabel('Packet Length (flit)','Rotation',-35,'FontSize',12);
zlabel('Latency (cycle)','FontSize',12);
end