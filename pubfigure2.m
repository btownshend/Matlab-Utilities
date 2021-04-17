% Save a figure for use in a publication
% Sets width, height in inches
% Use width,height as the dimensions of the current axes in the plot
function pubfigure2(filename,fnum,width,height,varargin)
  defaults=struct('tickfontsize',[],'axisfontsize',[],'titlefontsize',[],'format','epsc2','markersize',[],'xmarkersizer',8,'scale',1,'savedata',false,'minfontsize',10,'maxfontsize',14,'childfontsize',[],'units','inches','srcdata',[],'font',[],'extra',[1,1]);
  args=processargs(defaults,varargin);
  if nargin<2
    fnum=gcf;
  end
  if nargin<3 || isempty(width)
    width=6;
  end
  if nargin<4 || isempty(height)
    height=width*2/3;
  end
  
  if isempty(args.tickfontsize)
    args.tickfontsize=args.minfontsize;
  end
  if isempty(args.axisfontsize)
    args.axisfontsize=(args.minfontsize+args.maxfontsize)/2;
  end
  if isempty(args.titlefontsize)
    args.titlefontsize=args.maxfontsize;
  end
  if isempty(args.childfontsize)
    args.childfontsize=args.minfontsize;
  end
  if args.scale~=1
    width=width*args.scale;
    height=height*args.scale;
    args.tickfontsize=args.tickfontsize*args.scale;
    args.axisfontsize=args.axisfontsize*args.scale;
    args.titlefontsize=args.titlefontsize*args.scale;
    args.childfontsize=args.childfontsize*args.scale;
    if ~isempty(args.markersize)
      args.markersize=args.markersize*args.scale;
      args.xmarkersize=args.xmarkersize*args.scale;
    end
  end
  
  
  figure(fnum);
  %  set(gca,'Box','off');
  set(gcf,'PaperUnits',args.units);
  set(gcf,'Units',args.units);
  if ~isempty(args.font)
    set(gca,'FontName',args.font);
  end

  % Walk through children to update any font or marker sizes
  axes=get(gcf,'children');
  for j=1:length(axes)
    if ~strcmp(class(axes(j)),'matlab.graphics.axis.Axes')
      continue;
    end
    set(axes(j),'FontSize',args.tickfontsize);
    set(get(axes(j),'XLabel'),'FontSize',args.axisfontsize,'FontWeight','normal');
    set(get(axes(j),'YLabel'),'FontSize',args.axisfontsize,'FontWeight','normal');
    set(get(axes(j),'Title'),'FontSize',args.titlefontsize,'FontWeight','bold');
    c=get(axes(j),'Children');
    if ~isempty(args.markersize)
      for i=1:length(c)
        try
          if get(c(i),'Marker')=='x'
            set(c(i),'MarkerSize',args.xmarkersize);
          else
            set(c(i),'MarkerSize',args.markersize);
          end
        catch me
          %        fprintf('Ignoring exception\n');
        end
      end
    end
    for i=1:length(c)
      try
        set(c(i),'FontSize',args.childfontsize);
      catch me
        %        fprintf('Ignoring exception\n');
      end
    end
  end
  
  % Scale size so that axes are the desired size

  % Find position of axes
  priorpsn=get(gca,'Position');
  for i=1:10
    % Need to iterate as margins change slightly with figure resizing
    psn=get(gca,'Position');
    %psn(3)=psn(3)*.9;   % Reduce right border to avoid clipping
    fprintf('Border fractions: %.3f %.3f\n', psn(3:end));
    fpos=get(gcf,'Position');
    borders=(1-(psn(3:4)+priorpsn(3:4))/2).*fpos(3:4);
    priorpsn=psn;
    fwidth=width+borders(1);
    fheight=height+borders(2);

    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperPosition',[0 0 fwidth*args.extra(1) fheight*args.extra(2)]);  % Scale a bit to avoid clipping
    set(gcf,'PaperSize',[fwidth*args.extra(1) height*args.extra(2)])

    % Resize display figure as well as print figure
    set(gcf,'Position',[fpos(1) fpos(2) fwidth fheight]);
    pause(0.1);  % Pause to cause figure update
  end
  
  if strcmp(args.format,'vector')
    exportgraphics(gcf,filename,'contenttype','vector');
    fprintf('Exported vector graphics to %s\n', filename);
  else
    print(gcf,sprintf('-d%s',args.format),filename);
    fprintf('Saved figure to %s with format %s\n', filename,args.format);
  end
  if ~isempty(args.srcdata)
    % Explicit sourcedata in table form
    assert(istable(args.srcdata));
    writetable(args.srcdata,[filename,'.csv']);
  elseif args.savedata
    % Generic export data by querying figure handle data structure
    exportfigdata(gcf,[filename,'.csv']);
  end
  fprintf('gca.pos=[%f,%f,%f,%f]\n',get(gca,'Position'));
  args
end
