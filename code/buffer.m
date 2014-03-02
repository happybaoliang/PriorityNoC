
data=[
    [104 104 218 176 236 204 102 102];
    [104 104 212 180 230 198 102 102];
    [104 104 176 170 194 162 102 102];
    [104 104 172 172 190 158 102 102];
    [104 104 142 142 160 128 102 102];
    [104 104 140 140 158 132 102 102];
    [104 104 138 130 156 130 102 102];
    ];

handle=bar(data)
legend('nc-f1','rtc-f1','nc-f2','rtc-f2','nc-f3','rtc-f3','nc-f4','rtc-f4');
set(gca,'xTickLabel',{'B=4','B=5','B=6','B=7','B=8','B=9','B=10'},'FontSize',15)
xlabel('VC Depth','FontSize',15)
ylabel('End-to-End Latency (ns)','FontSize',15)

%legend('boxoff')