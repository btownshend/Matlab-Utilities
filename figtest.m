% Test various aspects of a figure

fig=gcf;
ax=gca;

setfig('figtest');clf;
drawbox(get(fig,'PaperPosition')*72,'f.ppos');
drawbox(get(fig,'Position'),'f.pos');
drawbox(get(fig,'InnerPosition'),'f.inpos');
drawbox(get(fig,'OuterPosition'),'f.outpos');
set(ax,'Units','points');
drawbox(get(ax,'Position'),'a.pos');
drawbox(get(ax,'OuterPosition'),'a.outpos');
axis equal;
figure(fig);

function drawbox(bb,lbl)
c=bb+[0,0,bb(1),bb(2)];
plot(c([1,1,3,3,1]),c([2,4,4,2,2]));
hold on;
text(c(3),c(4),lbl,'HorizontalAlignment','right','VerticalAlignment','top');
fprintf('%s=[%s]\n',lbl,sprintf('%f ',c));
end


