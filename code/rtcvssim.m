function test()
Labelx={'f1(sim)' 'f1(rtc)' 'f2(sim)' 'f2(rtc)' 'f4(sim)' 'f4(rtc)' 'f3(sim)' 'f3(rtc)'};
Labely={'9','8','7','6','5','4','3','2'};
Z=[ 37      37       34      42        37      37 38     46;    %9
    34      35       32      40        35      35 28     43;    %8
    33      33       32      38        33      33 27     47;    %7
    30      31       31      36        31      31 27     43;    %6
    28      29       30      34        29      29 28     39;    %5
    26      27       29      32        27      27 27     39;    %4
    24      25       27      30        25      25 27     34;    %3
    22      23       30      30        23      23 25     31];   %2                                 
%'RTC(0)'  'SIM(0)'  'RTC(1)'  'SIM(1)' 'RTC(2)' 'SIM(2)' 'RTC(3)' 'SIM(3)'
hb=bar3(Z);
%colorbar;
set(gca,'xticklabel',Labelx,'FontSize',10);
set(gca,'yticklabel',Labely,'FontSize',10);
xlabel('simulation vs. rtc','Rotation',20,'FontSize',12);
ylabel('Packet Length (flits)','Rotation',-35,'FontSize',12);
zlabel('Latency (cycle)','FontSize',12);
end
