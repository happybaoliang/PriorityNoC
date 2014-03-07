
data=[
    [52 52 109 82 59 102 51 51];
    [52 52 106 90 115 99 51 51];
    [52 52 88 85 97 81 51 51];
    [52 52 86 86 95 79 51 51];
    [52 52 71 71 80 64 51 51];
    [52 52 70 70 79 66 51 51];
    [52 52 69 65 78 65 51 51];
    ];

handle=bar(data)
legend('DNC-f1','RTC-f1','DNC-f2','RTC-f2','DNC-f3','RTC-f3','DNC-f4','RTC-f4');
set(gca,'xTickLabel',{'B=4','B=5','B=6','B=7','B=8','B=9','B=10'},'FontSize',15)
xlabel('Buffer Size','FontSize',15)
ylabel('End-to-End Latency (cycle)','FontSize',15)

%legend('boxoff')