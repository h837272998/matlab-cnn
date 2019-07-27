function H = myHist(ima)
ima      = double(ima);
[r,c]    = size(ima);
L        = 256;
H        = zeros(256,1);
for k    = 1:L
    rk   = k - 1;
    ind  = find(ima(:)==rk);
    H(k) = length(ind);
end
H        = H/(r*c);