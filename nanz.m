% nanz - convert NaN's to zero
function x=nanz(x)
x(isnan(x))=0;
