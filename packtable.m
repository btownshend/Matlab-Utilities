% Display a table with any unneeded space removed
function packtable(x)
t=evalc('x');
t=strrep(strrep(t,'<strong>',''),'</strong>','');
s=char(strsplit(t,'\n'));  % Character array
for i=1:size(s,2)
  if i==1
    repress=s(:,i)==' ';
  else
    repress=s(:,i)==' ' & (s(:,i-1)==' ' | s(:,i-1)=='@');
  end
  s(repress,i)='@';
end

s=s(4:end,:);   % Remove header
keep=any(~ismember(s(2:end,:),['''','_','@']));
keeph=keep;
for i=length(keeph):-1:2
  if ~keeph(i) && s(1,i)~='@'
    % Move back space removal
    for k=i-1:-1:1
      if keeph(k)
        break;
      end
    end
    keeph(k)=0;
    keeph(i)=1;
  end
end
sout=[s(1,keeph);s(2:end,keep)];
sout(:)=strrep(sout(:)','@',' ');
res=strjoin(cellstr(sout),'\n');
disp(res);
end


