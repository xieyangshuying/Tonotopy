figure
X=[];G=[];
for i=1:size(data,2) 
    temp=data(:,i);
    temp(isnan(temp))=[];
    X=[X;temp];
    G=[G;ones(length(temp),1)*i];   
end
    a1=-0.1;b1=0.1;
    ind=a1 + (b1-a1).*rand([length(G) 1]);
    plot(G+ind,X,'o','markersize',4,'MarkerfaceColor',[153 153 153]/255,'MarkerEdgeColor','none')  %  
    hold on,
    boxplot(X,G,'colors',[0 0 0],'width',0.3,'symbol','');  
    h = findobj(gca, 'Type', 'Line'); 
    set(h, 'LineWidth', 2);
    ylabel('Median BF (TR neurons)')
    set(gca,'xtick',1:size(data,2))
    set(gca,'fontsize',15)
     box off
     ylim([0 25]) 
    ax = gca;
    ax.XAxis.TickDirection = 'out';
    ax.YAxis.TickDirection = 'out';
    ax.XAxis.LineWidth = 1.5;  
    ax.YAxis.LineWidth = 1.5;  