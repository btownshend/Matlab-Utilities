function bytes=memused(x,minsize,nm)
% Find memory used by x
if nargin<2
  minsize=512;
  fprintf('Showing elements with size>=%d\n',minsize);
end
if nargin<3
  nm='';
end
if strcmp(class(x),'containers.Map')
  bytes=memused(x.keys,minsize,'keys')+memused(x.values,minsize,'values')+8;
elseif isstruct(x) || isobject(x)
  fn=fieldnames(x);
  sz=[];
  for i=1:length(fn)
    subnm=[nm,'.',fn{i}];
    if length(x)>1
      if iscell(x(1).(fn{i}))
        sz(i)=memused({x.(fn{i})},minsize,subnm);
      else
        sz(i)=0;
        for j=1:length(x)
          sz(i)=sz(i)+memused(x(j).(fn{i}),minsize,subnm);
        end
      end
    else
      sz(i)=memused(x.(fn{i}),minsize,subnm);
    end
  end
  bytes=sum(sz);
else
  w=whos('x');
  bytes=w.bytes;
end
if bytes>=minsize
  fprintf('%11.0f %s\n', bytes, nm);
end
end
