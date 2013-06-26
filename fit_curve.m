function [ params,ci, Survival] = fit_curve( Time, Descriptive_means )

% Fit to a Gompertz function

Gomp=@(A,mu,lamb,x)A*exp(-exp((mu*exp(1)/A)*(lamb-x)+1));

j=1;

for l=1:3

[fits, goodnes{l}, residuals{l}] =fit(Time,Descriptive_means(:,l),Gomp,'Algorithm','Levenberg-Marquardt','Robust', 'LAR');


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


end

