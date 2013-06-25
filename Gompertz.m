function [y] = Gompertz(A,mu,lamb,t)

%   Computes the Gompertz model of population growth
% Params: A = the asymptote
%         mu = maximum growth rate
%         lamb = lag constant





y=A*exp(-exp((mu*exp(1)/A)*(lamb-t)+1));





end

