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


%% Importing the dataset


D30 = importdata('30.csv');

D35 = importdata('35.csv');

D40 = importdata('40.csv');

D42 = importdata('42.csv');

Data_array = {D30.data,D35.data,D40.data,D42.data} ;

% Set the time array


Time=cell(1,4);

for i=1:4
   
   Time{i}= [0:5:5*(size(Data_array{i},1)-1)]';  
    
end

% Plot variables

set(0,'defaultaxesfontsize',16);
scrsz = get(0,'ScreenSize');



%% Descriptives

blank_array=cell(1,4);

Descriptives_array=cell(1,4);


for i=1:4
    
[blank,Descriptives] = descriptives_growth(Data_array{i});


blank_array{i}=blank;

Descriptives_array{i}=Descriptives;

end
 
%% Curve fitting


params_array=cell(1,4);

ci_array=cell(1,4);

Survival_array=cell(1,4);


for i=1:4
    
  Time_temp=Time{i};
  
  Descriptive_temp=Descriptives_array{i};
  
  Descriptive_means=Descriptive_temp.means;
  
    
[ params,ci, Survival] = fit_curve( Time_temp, Descriptive_means );
 
params_array{i}=params;

ci_array{i}=ci;

Survival_array{i}=Survival;
 
 

end

%% Survival curve plot growth rate

FoS1 = 15;

% Figure properties

cbSet3n12 = [141, 211, 199; 255, 255, 179; 190, 186, 218; 251, 128, 114; 128, 177, 211; 253, 180, 98; 179, 222, 105; 252, 205, 229; 217, 217, 217; 188, 128, 189; 204, 235, 197; 255, 237, 111]/255;
IDX = [1 1 1 2 2 2 3 3 3 4 4 4 5 5 5];
kidx=[1;2;3];

hf6=figure('Visible','on','Position',[0 0 scrsz(3)/3 scrsz(4)*3/4],'Color','w');
colormap(cbSet3n12);


set(gca,'FontSize',FoS1);

% Getting the mean values of the parameters

for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   mu(i)=Temp.meanmu; 
   
    
end

for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   A(i)=Temp.meanA; 
    
end

for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   lamb(i)=Temp.meanlamb; 
    
end


% Getting the propagated confidence intervals of the parameters 


for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   mu_ci(i)=Temp.cimu; 
   
    
end

for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   A_ci(i)=Temp.ciA; 
    
end

for i=1:size(Survival_array,2)
    
   Temp = Survival_array{i};
   
   lamb_ci(i)=Temp.cilamb; 
    
end

% Filtering the first case

mu(1)=[];

A(1)=[];

lamb(1)=[];

mu_ci(1)=[];

A_ci(1)=[];

lamb_ci(1)=[];

% Plots

Temperature=[35,40,42];




hold on
scatter(Temperature,mu,200,kidx,'filled','o');
errorbar(Temperature,mu,mu_ci,'k.');

set(gca,'LineWidth',2);
xlabel('Temperature (C^o)');
ylabel('Growth rate (absorbance units/minute)');

hold off


export_fig('mu.pdf');
clf;


hold on
scatter(Temperature,A,200,kidx,'filled','o');
errorbar(Temperature,A,A_ci,'k.');

set(gca,'LineWidth',2);
xlabel('Temperature (C^o)');
ylabel('Carrying capacity (absorbance units)');

hold off


export_fig('A.pdf');
clf;


hold on
scatter(Temperature,lamb,200,kidx,'filled','o');
errorbar(Temperature,lamb,lamb_ci,'k.');

set(gca,'LineWidth',2);
xlabel('Temperature (C^o)');
ylabel('Lag time (minute)');

hold off



export_fig('lamb.pdf');

clf;


%% Individual curve fitting

% %% Parameter plots
% 
% % Fit to a Gompertz function
% 
% Gomp=@(A,mu,lamb,x)A*exp(-exp((mu*exp(1)/A)*(lamb-x)+1));
% 
% j=1;
% 
% for l=1:3
% 
% [fits, goodnes{l}, residuals{l}] =fit(Time,Descriptives.means(:,l),Gomp,'Algorithm','Levenberg-Marquardt','Robust', 'LAR');
% 
% % Preparing the figures
% 
%  hfLen(j)=figure('Visible','off','Position',[0 0 scrsz(3)/4 scrsz(4)/2]);
%  set(hfLen(j),'Color','w');
%  
% plot(fits, Time,Descriptives.means(:,l));
% 
% j=j+1;
% 
%  hfLen(j)=figure('Visible','off','Position',[0 0 scrsz(3)/4 scrsz(4)/2]);
%  set(hfLen(j),'Color','w');
% 
% 
% stem(Time, residuals{l}.residuals);
% 
% 
% j=j+1;
% 
% % Obtaining the parameters
% 
% params.A(l)=fits.A;
% 
% params.mu(l)=fits.mu;
% 
% params.lamb(l)=fits.lamb;
% 
% % Confidence intervals
% 
% temp=confint(fits,0.95);
% 
% tempA=temp(:,1);
% 
% tempmu=temp(:,2);
% 
% templamb=temp(:,3);
% 
% ci.A(:,l)=tempA;
% 
% ci.mu(:,l)=tempmu;
% 
% ci.lamb(:,l)=templamb;
% 
% % Parameter averages and combined errors for a given temperature-to be
% % scaled for the general case
% 
% 
% Survival.meanA=mean(params.A);
% Survival.meanmu=mean(params.mu);
% Survival.meanlamb=mean(params.lamb);
% 
% 
% Survival.ciA=1/3*sqrt(sum((params.A-ci.A(1,:)).^2));
% Survival.cimu=1/3*sqrt(sum((params.mu-ci.mu(1,:)).^2));
% Survival.cilamb=1/3*sqrt(sum((params.lamb-ci.lamb(1,:)).^2));
% 
% end
% 
% % Saving the figures
% 
% 
% for i = 1:length(hfLen)
%     figname = ['fig_' num2str(hfLen(i)) '.jpg'];
%     figure(hfLen(i))
%     export_fig(figname) % ,'r150');
%     close(hfLen(i))
% end
% 
% %% Parameter plots
% 
% FoS1 = 15;
% 
% %Colors
% 
% cbSet3n12 = [141, 211, 199; 255, 255, 179; 190, 186, 218; 251, 128, 114; 128, 177, 211; 253, 180, 98; 179, 222, 105; 252, 205, 229; 217, 217, 217; 188, 128, 189; 204, 235, 197; 255, 237, 111]/255;
% IDX = [1 1 1 2 2 2 3 3 3 4 4 4 5 5 5];
% kidx=[1;2;3];
% 
% 
% 
% hf6=figure('Visible','on','Position',[0 0 scrsz(3)/3 scrsz(4)*3/4],'Color','w');
% colormap(cbSet3n12);
% 
% 
% set(gca,'FontSize',FoS1);
% 
% %A
% 
% A_confidence(1,:)=params.A-ci.A(1,:);
% 
% A_confidence(2,:)=ci.A(2,:)-params.A;
% 
% sample=1:3;
% 
% points=[params.A;sample];
% hold on
% scatter(sample,params.A,200,kidx,'filled','o');
% errorbar(sample,params.A,A_confidence(1,:),A_confidence(2,:));
% hold off
% 
% 
% %% Parameter plots
% 
% FoS1 = 15;
% 
% %Colors
% 
% cbSet3n12 = [141, 211, 199; 255, 255, 179; 190, 186, 218; 251, 128, 114; 128, 177, 211; 253, 180, 98; 179, 222, 105; 252, 205, 229; 217, 217, 217; 188, 128, 189; 204, 235, 197; 255, 237, 111]/255;
% IDX = [1 1 1 2 2 2 3 3 3 4 4 4 5 5 5];
% kidx=[1;2;3];
% 
% 
% 
% hf6=figure('Visible','on','Position',[0 0 scrsz(3)/3 scrsz(4)*3/4],'Color','w');
% colormap(cbSet3n12);
% 
% 
% set(gca,'FontSize',FoS1);
% %mu
% 
% mu_confidence(1,:)=params.mu-ci.mu(1,:);
% 
% mu_confidence(2,:)=ci.mu(2,:)-params.mu;
% 
% points=[params.mu;sample];
% 
% hold on
% scatter(sample,params.mu,200,kidx,'filled','o');
% errorbar(sample,params.mu,mu_confidence(1,:),mu_confidence(2,:));
% hold off


 