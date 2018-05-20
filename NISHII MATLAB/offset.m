function d=offset(w,y,a,b)
r=y(:,b)
z=repmat(r,1,a)
d=y-z
plot(w,d)
end