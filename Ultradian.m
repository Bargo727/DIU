function out = Ultradian(t,y)
global E Vp Vi Vg tp ti td Rm Rg C1 C2 C3 C4 C5 a1 Ub U0 Um a b G K eps T A
kappa = (1/C4)*((1/Vi)-(1/(ti*E)));
f1 = @(x) Rm/(1 + exp((-x/(Vg*C1))+a1));
f2 = @(x) Ub*(1 - exp((-x/(C2*Vg))));
f3 = @(x) (1/(C3*Vg))*(U0 + ((Um - U0)/(1 + (kappa*x)^(-b))));
f4 = @(x) Rg/(1+exp(a*((x/(C5*Vp))-1)));

IG = @(x) G;

%uncomment for alternative forcing
 for n = 1:K
    %uncomment for square pulse forcing
%   %IG = @(x) IG(x) + (A/eps)*(sign(heaviside(x - n*T)) - sign(heaviside(x - n*T-eps))); 

    %uncomment for Gaussian forcing
   %IG = @(x) IG(x) + (A/(eps*sqrt(pi)))*exp(-((x-n*T)/eps)^2);

    %uncomment for forcing at breakfast, lunch, and dinner
%    IG = @(x) IG(x) + (A/(eps*sqrt(pi)))*exp(-((x-(480 + (n-1)*1440))/eps)^2) + (A/(eps*sqrt(pi)))*exp(-((x-(720+ (n-1)*1440))/eps)^2) + (A/(eps*sqrt(pi)))*exp(-((x-(1080+ (n-1)*1440))/eps)^2);
 end


out = [f1(y(3))-E*((y(1)/Vp)-(y(2)/Vi))-(y(1)/tp);E*((y(1)/Vp)-(y(2)/Vi))-(y(2)/ti);f4(y(6))+IG(t)-f2(y(3))-f3(y(2))*y(3);(1/td)*(y(1)-y(4));(1/td)*(y(4)-y(5));(1/td)*(y(5)-y(6))];
end