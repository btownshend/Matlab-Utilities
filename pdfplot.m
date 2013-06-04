% pdfplot - plot PDF of data
function h=pdfplot(x,popts,dolog,nbins)
if nargin<2 || length(popts)==0
  popts='-';
end
if nargin<3
  dolog=0;
end
if nargin<4
  nbins=max(2,min([ceil(length(x)/10), 200]));
end
xs=sort(x);
first=1;
px=[]; py=[];
for i=1:nbins
  last=round(i/nbins*length(xs));
  pval=(last-first+1)/length(xs)/(xs(last)-xs(first));
  px=[px,xs(first),xs(last)];
  py=[py,pval,pval];
  first=last+1;
end
if dolog
  h=semilogx(px,py.*px,popts);
  ylabel('PDF (scaled by X)');
else
  h=plot(px,py,popts);
  ylabel('PDF');
end
