% Save a figure for use in powerpoint or prezi
function mkinsert(filename,fnum,aspect,dpi)
  if nargin<2
    fnum=gcf;
  end
  if nargin<4
    dpi=72;
  end
  figure(fnum);
  fontsize=16;
  if nargin<3
    %aspect=4/3;
    aspect=16/9;
  end
  width=1280;   
  height=width/aspect;
  width=width-0.5;% Always end up with 1 extra pixel 
  height=height-0.5;

  ps=get(gcf,'position');
  ps(3)=width;
  ps(4)=height;
  set(gcf,'position',ps);
  set(gcf,'PaperUnits','inches');
  resolution=72;
  set(gcf,'PaperPosition',[0 0 width height]/resolution);
  set(gcf,'PaperSize',[width height]/resolution);
  axes=get(gcf,'children')
  for j=1:length(axes)
    set(axes(j),'FontSize',fontsize);
    set(get(axes(j),'XLabel'),'FontSize',fontsize,'FontWeight','bold');
    set(get(axes(j),'YLabel'),'FontSize',fontsize,'FontWeight','bold');
    set(get(axes(j),'Title'),'FontSize',fontsize,'FontWeight','bold');
    c=get(axes(j),'Children');
    for i=1:length(c)
      try
        set(c(i),'MarkerSize',20);
      catch me
        fprintf('Ignoring exception\n');
      end
    end
  end
  print(gcf,'-dpng',['-r',num2str(dpi)],filename);
  fprintf('Saved figure to %s\n', [filename,'.png']);
end
