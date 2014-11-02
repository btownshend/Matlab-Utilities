% Add logarithmic ticks to an axis
function logticks
c=axis;
for ax=1:2
  ticks=[];
  ticklabels={};
  for i=floor(log10(c(ax*2-1))):ceil(log10(c(ax*2)))
    if i<0
      fmt=sprintf('%%.%df',-i);
    end
    for j=1:9
      tval=j*10^i;
      if tval<c(ax*2-1) || tval>c(ax*2)
        continue;
      end
      ticks(end+1)=tval;
      if j==1 || j==2 || j==5
        ticklabels{end+1}=sprintf(fmt,tval);
      else
        ticklabels{end+1}='';
      end
    end
  end
  if ax==1
    set(gca,'XTick',ticks);
    set(gca,'XTickLabel',ticklabels);
  else
    set(gca,'YTick',ticks);
    set(gca,'YTickLabel',ticklabels);
  end
end
