function [X]=newgx(X)
X=X-1;

X(X<0)=0;

X(X>1)=1;

