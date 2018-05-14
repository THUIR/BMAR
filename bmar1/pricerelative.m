function data_phi=pricerelative(data,W)
[T, N] = size(data);
if (T < W+1)
    data_phi = data(T, :);
else
%    data_phi = data(T-W+1, :);
    data_phi = zeros(1, N);
    tmp_x = ones(1, N);
    for i = 1:W
        data_phi = data_phi + 1./tmp_x;
        tmp_x = tmp_x.*data(T-i+1, :);
    end
    
    data_phi = data_phi*(1/W);
end