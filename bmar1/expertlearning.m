function [data_phi,losses]=expertlearning(data_phi_w,data,losses,W);
[Ne,N]=size(data_phi_w);
[T,N]=size(data);
eta=1;
%[candidate_loss,mid]=sort(losses,'ascend');
data_phi=exp(-eta*losses')/sum(exp(-eta*losses))*data_phi_w;
%data_phi=losses'./(losses').^2*data_phi_w;
%exp(-eta*candidate_loss(1:floor(Ne/2))')/sum(exp(-eta*candidate_loss(1:floor(Ne/2))'))*data_phi_w(mid(1:floor(Ne/2)),:);
temploss=zeros(Ne,1);
if T>W
for i=1:Ne
    temploss(i)=(sum((data(T,:)-data_phi_w(i,:)).^2)/N);%(sum((data(T,:)./data_phi_w(i,:)-ones(1,N)).^2)/N);%1-exp(-(sum((data(T,:)-data_phi_w(i,:)).^2)/N));%(prod((data(T,:)-data_phi_w(i,:)).^2))^(1/(2*N));
    losses(i)=losses(i)+temploss(i);%sqrt(sum((data(T,:)-data_phi_w(i,:)).^2)/N);%1-exp(-(sum((data(T,:)-data_phi_w(i,:)).^2)/N));%1-exp(-sqrt(sum((data(T,:)-data_phi_w(i,:)).^2)/N));%
end
%ploss=ploss+(sum((data(T,:)-data_phi).^2)/N);%
end
% if T<W+10
% display(losses);
% end