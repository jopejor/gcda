%-----------------------------
%
% Plot bioscreen data
% Cameron Smith
% 05/26/2013
%
%
%-----------------------------

clear; close all;

% fid = fopen('test5_25_13_247PM2.csv');
% D = textscan(fid,'%*s %f %f %f ','HeaderLines',1,'Delimiter',',');
D = importdata('test5_26_13_434PM.csv');
set(0,'defaultaxesfontsize',16);
scrsz = get(0,'ScreenSize');

Dat = D.data;
j=0;
for i = 1:size(Dat,2)
    if ~(mod(i-1,10))
        j=j+1;
        %figure(j)
        hfLen(j)=figure('Visible','off','Position',[0 0 scrsz(3)/4 scrsz(4)/2]);
        set(hfLen(j),'Color','w');
    end
    hold on
    plot(Dat(:,i),'ko');
    hold off
end

for i = 1:length(hfLen)
    figname = ['fig_' num2str(hfLen(i)) '.jpg'];
    figure(hfLen(i))
    export_fig(figname) % ,'r150');
    close(hfLen(i))
end
    
%close all;