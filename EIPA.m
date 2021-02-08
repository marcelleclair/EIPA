set(0,'DefaultFigureWindowStyle','docked')

nx = 50;
ny = nx;

G = zeros(nx*ny, nx*ny); % preallocate G for speed
bounds = false(ny,nx);
bounds(:,[1,nx]) = 1;
bounds([1,ny],:) = 1;
bv = bounds(:); % logical index of boundaries in vector form
% bd = bv & logical(eye(nx*ny)); % logical index of boundary diagonal elements
% 
ds = 1; % orthogonal distance between nodes, assumed dx = dy = ds
alpha = 1;
B = 1/(alpha * ds^2);
% G(bd) = 1;
sp = false(ny,nx);
%sp(20:30,20:30) = 1;
spv = sp(:); % logical index of cells with special conditions
for m = 1 : nx*ny
    if bv(m)
        G(m,m) = 1;
    else
        if spv(m)
            G(m,m) = -2*B;
        else
            G(m,m) = -4*B;
        end
        G(m,m-ny) = B;
        G(m,m+ny) = B;
        G(m,m-1) = B;
        G(m,m+1) = B;
    end
end

[E,D] = eigs(G,9,'SM');

for n = 1 : 9
    figure(n)
    surf(reshape(E(:,n),[ny,nx]));
end