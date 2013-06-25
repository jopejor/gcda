%-------------------------------------------------
%
% Ximo Pechuan
% Date: 6.3.2013
%
% Curve fitting
% for Experimental evolution
%
%-------------------------------------------------

% Media is in the last


% Import the dataset


D = importdata('20130608_40C.csv');

Dat = D.data;

set(0,'defaultaxesfontsize',16);
scrsz = get(0,'ScreenSize');




% Set the time vector

Time=[0:5:5*(size(Dat,1)-1)]';

% Calculate the blank

blank.mean= mean(Dat(:,size(Dat,2)));

blank.std=std(Dat(:,size(Dat,2)));

blank.cv=blank.std/blank.mean*100;

% Calculate the descriptives

Descriptives.std=zeros(size(Dat,1),3);

Descriptives.means=zeros(size(Dat,1),3);

 i=1;
 
 
for i= 1:size(Dat,1)
     
    
     j=1;
     k=1;
    
    
    
   
    
   for j=1:3

       
    Temp_dat1=Dat(i,(k:k+8))-blank.mean; 
    
    k=k+2;
    
    
    Temp_dat2=Dat(i,(k:k+8))-blank.mean; 
    
    k=k+2;
    
    
    Temp_dat3=Dat(i,(k:k+8))-blank.mean; 
    
    Temp_dat=[Temp_dat1, Temp_dat2,Temp_dat3];
    
    Descriptives.std(i,j)=std(Temp_dat);

    Descriptives.means(i,j)=mean(Temp_dat);
    
    k=k+2;
    
   end

   
   
end
    
% Fit to a Gompertz function

Gomp=@(A,mu,lamb,x)A*exp(-exp((mu*exp(1)/A)*(lamb-x)+1));

j=1;

for l=1:3

[fits, goodnes{l}, residuals{l}] =fit(Time,Descriptives.means(:,l),Gomp,'Algorithm','Levenberg-Marquardt','Robust', 'LAR');

% Preparing the figures

 hfLen(j)=figure('Visible','off','Position',[0 0 scrsz(3)/4 scrsz(4)/2]);
 set(hfLen(j),'Color','w');
 
plot(fits, Time,Descriptives.means(:,l));

j=j+1;

 hfLen(j)=figure('Visible','off','Position',[0 0 scrsz(3)/4 scrsz(4)/2]);
 set(hfLen(j),'Color','w');


stem(Time, residuals{l}.residuals);


j=j+1;

% Obtaining the parameters

params.A(l)=fits.A;

params.mu(l)=fits.mu;

params.lamb(l)=fits.lamb;

% Confidence intervals

temp=confint(fits,0.95);

tempA=temp(:,1);

tempmu=temp(:,2);

templamb=temp(:,3);

ci.A(:,l)=tempA;

ci.mu(:,l)=tempmu;

ci.lamb(:,l)=templamb;

% Parameter averages and combined errors for a given temperature-to be
% scaled for the general case


Survival.meanA=mean(params.A);
Survival.meanmu=mean(params.mu);
Survival.meanlamb=mean(params.lamb);


Survival.ciA=1/3*sqrt(sum((params.A-ci.A(1,:)).^2));
Survival.cimu=1/3*sqrt(sum((params.mu-ci.mu(1,:)).^2));
Survival.cilamb=1/3*sqrt(sum((params.lamb-ci.lamb(1,:)).^2));

end

% Saving the figures


for i = 1:length(hfLen)
    figname = ['fig_' num2str(hfLen(i)) '.jpg'];
    figure(hfLen(i))
    export_fig(figname) % ,'r150');
    close(hfLen(i))
end

%% Parameter plots

FoS1 = 15;

%Colors

cbSet3n12 = [141, 211, 199; 255, 255, 179; 190, 186, 218; 251, 128, 114; 128, 177, 211; 253, 180, 98; 179, 222, 105; 252, 205, 229; 217, 217, 217; 188, 128, 189; 204, 235, 197; 255, 237, 111]/255;
IDX = [1 1 1 2 2 2 3 3 3 4 4 4 5 5 5];
kidx=[1;2;3];



hf6=figure('Visible','on','Position',[0 0 scrsz(3)/3 scrsz(4)*3/4],'Color','w');
colormap(cbSet3n12);


set(gca,'FontSize',FoS1);

%A

A_confidence(1,:)=params.A-ci.A(1,:);

A_confidence(2,:)=ci.A(2,:)-params.A;

sample=1:3;

points=[params.A;sample];
hold on
scatter(sample,params.A,200,kidx,'filled','o');
errorbar(sample,params.A,A_confidence(1,:),A_confidence(2,:));
hold off


%% Parameter plots

FoS1 = 15;

%Colors

cbSet3n12 = [141, 211, 199; 255, 255, 179; 190, 186, 218; 251, 128, 114; 128, 177, 211; 253, 180, 98; 179, 222, 105; 252, 205, 229; 217, 217, 217; 188, 128, 189; 204, 235, 197; 255, 237, 111]/255;
IDX = [1 1 1 2 2 2 3 3 3 4 4 4 5 5 5];
kidx=[1;2;3];



hf6=figure('Visible','on','Position',[0 0 scrsz(3)/3 scrsz(4)*3/4],'Color','w');
colormap(cbSet3n12);


set(gca,'FontSize',FoS1);
%mu

mu_confidence(1,:)=params.mu-ci.mu(1,:);

mu_confidence(2,:)=ci.mu(2,:)-params.mu;

points=[params.mu;sample];

hold on
scatter(sample,params.mu,200,kidx,'filled','o');
errorbar(sample,params.mu,mu_confidence(1,:),mu_confidence(2,:));
hold off


 