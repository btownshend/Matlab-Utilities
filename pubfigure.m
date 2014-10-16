% Save a figure for use in a publication
% Sets width, height in inches
function pubfigure(filename,fnum,width,height)
  tickfontsize=10;
  axisfontsize=12;
  titlefontsize=14;
  if nargin<2
    fnum=gcf;
  end
  if nargin<3
    width=6;
  end
  if nargin<4
    height=width*2/3;
  end
  figure(fnum);

  set(gca,'Box','off');
  % left, bottom, right, top margins
  ps=get(gca,'Position'); % Need to handle stuff at right, such as colorbars
  margins=axisfontsize*[3.5 3 1 1]/72;
  if ~isempty(get(get(gca,'Title'),'String'))
    margins(4)=titlefontsize*2.5/72;
  end
  ps(1)=margins(1)/width;
  ps(2)=margins(2)/height;
  ps(4)=1-(margins(2)+margins(4))/height;
  % set(gca,'Position',ps);
  set(gcf,'PaperUnits','inches');
  set(gcf,'PaperPosition',[0 0 width height]);
  set(gcf,'PaperSize',[width height]);
  set(gcf,'Units','inches');
  ps=get(gcf,'Position')
  set(gcf,'Position',[ps(1) ps(2) width height]);
  axes=get(gcf,'children')
  for j=1:length(axes)
    if ~strcmp(class(axes(j)),'matlab.graphics.axis.Axes')
      continue;
    end
    set(axes(j),'FontSize',tickfontsize);
    set(get(axes(j),'XLabel'),'FontSize',axisfontsize,'FontWeight','normal');
    set(get(axes(j),'YLabel'),'FontSize',axisfontsize,'FontWeight','normal');
    set(get(axes(j),'Title'),'FontSize',titlefontsize,'FontWeight','bold');
    c=get(axes(j),'Children');
    for i=1:length(c)
      try
        set(c(i),'MarkerSize',20);
      catch me
        fprintf('Ignoring exception\n');
      end
    end
  end
  print(gcf,'-depsc2',filename);
  fprintf('Saved figure to %s\n', filename);
end
