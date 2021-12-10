%% plot shadebar of ERP
% by Hang-Bin Zhang 
% Shanghai Mental Health Center
% University of Manchester
function [a]=plotERP(selchan,seltime,dat,col)
%% plot with error bar
%dataname = sprintf('%s',inputname(3));
chanlabel = (dat{1}.label(selchan));
titlename_origin = strcat(string(chanlabel),',');
titlename = strcat('mean(',titlename_origin{:},')');
varargin = dat;
Ndata = numel(varargin);
xparam = 'time';
xminindx = nearest(varargin{1}.(xparam), min(seltime));
xmaxindx = nearest(varargin{1}.(xparam), max(seltime));
%xmin = varargin{1}.(xparam)(xminindx);
%xmax = varargin{1}.(xparam)(xmaxindx);
selx = xminindx:xmaxindx;
xval = varargin{1}.(xparam)(selx);
datamatrix = zeros(Ndata, length(selx));
for i=1:Ndata
  datamatrix(i,:) = mean(varargin{i}.avg(selchan, selx), 1); % mean over channels
end
x = xval*1000;
y = datamatrix;
a = plot(x,mean(y,1),col);
%legend(dataname); %线条注释,多条的话:legend('xxx','xxx2','xxx3'）
title(titlename);
