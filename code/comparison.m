data=[56 50 46;62 58 48;110 94 78;162 146 112;246 214 144]
handle=bar(data)
set(gca,'xTickLabel',{'L=1','L=4','L=8','L=12','L=16'},'FontSize',15)
xlabel('Packet Length','FontSize',15)
ylabel('End-to-End Latency (ns)','FontSize',15)
legend('NC','RTC','SIM')

ncy=get(handle(1),'YData')
ncx=get(handle(1),'XData')
rtcy=get(handle(2),'YData')
rtcx=get(handle(2),'XData')
simy=get(handle(3),'YData')
simx=get(handle(3),'XData')

ydist=5;

xdist=-0.32;
text(ncx(1)+xdist,ncy(1)+ydist,num2str(ncy(1)));
text(ncx(2)+xdist,ncy(2)+ydist,num2str(ncy(2)));
text(ncx(3)+xdist,ncy(3)+ydist,num2str(ncy(3)));
text(ncx(4)+xdist,ncy(4)+ydist,num2str(ncy(4)));
text(ncx(5)+xdist,ncy(5)+ydist,num2str(ncy(5)));

xdist=-0.1;
text(rtcx(1)+xdist,rtcy(1)+ydist,num2str(rtcy(1)));
text(rtcx(2)+xdist,rtcy(2)+ydist,num2str(rtcy(2)));
text(rtcx(3)+xdist,rtcy(3)+ydist,num2str(rtcy(3)));
text(rtcx(4)+xdist,rtcy(4)+ydist,num2str(rtcy(4)));
text(rtcx(5)+xdist,rtcy(5)+ydist,num2str(rtcy(5)));

xdist=0.12;
text(simx(1)+xdist,simy(1)+ydist,num2str(simy(1)));
text(simx(2)+xdist,simy(2)+ydist,num2str(simy(2)));
text(simx(3)+xdist,simy(3)+ydist,num2str(simy(3)));
text(simx(4)+xdist,simy(4)+ydist,num2str(simy(4)));
text(simx(5)+xdist,simy(5)+ydist,num2str(simy(5)));