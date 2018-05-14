%function [weight, expertloss, predictloss] = olmar1_expert_meta(data, weight_o, epsilon, W, expertloss, predictloss)
function [weight,losses] = olmar1_expert_meta(data, weight_o, epsilon, W, losses)
% This program generates portfolio for a specified parameter setting.
% OLMAR-1 expert
%
% function weight = olmar1_expert(data, weight_o, epsilon, W)
%
% weight: experts portfolio, used for next rebalance/combination
%
% data: market sequence vectors
% weight_o: last portfolio
% epsilon: mean reversion threshold
% W: window size for calculating moving average
%
% Example: weight = olmar1_expert(data, weight_o, epsilon, W)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of OLPS: http://OLPS.stevenhoi.org/
% Original authors: Bin LI, Steven C.H. Hoi
% Contributors:
% Change log: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[T, N] = size(data);
Ne=W-1;
data_phi_w=zeros(Ne,N);
%stepsize=1;
% windows=zeros(1,Ne);
% for i=1:Ne
%     windows(i)=(i-Ne/2)*stepsize+W;
% end
windows=2:1:W;%W-4:1:W+5;%zeros(Ne,1);
for w=1:Ne
    data_phi_w(w,:)=pricerelative(data(1:(T-1),:),windows(w));
end
[data_phi,losses]=expertlearning(data_phi_w,data,losses,W);
% if T<W+10
% display(losses);
% end
%data_phi=pricerelative(data,W);

% Step 3: Suffer loss
ell = max([0 epsilon - data_phi*weight_o]);

% Step 4: Set parameter
x_bar = mean(data_phi);
denominator = (data_phi - x_bar)*(data_phi - x_bar)';
if (~eq(denominator, 0.0)),
    lambda = ell / denominator;
else  % Zero volatility
    lambda = 0;
end

% Step 5: Update portfolio
weight = weight_o + lambda*(data_phi' - x_bar);

% Step 6: Normalize portfolio
weight = simplex_projection(weight, 1);

end