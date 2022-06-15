 clear;

global E Vp Vi Vg tp ti td Rm Rg C1 C2 C3 C4 C5 k a1 Ub U0 Um a b G K T eps A
Vp = 3;
Vi = 11;
Vg = 10;
E  = .2;
tp = 6;
ti = 100;
td = 12;
k  = 0.5;
Rm = 209;
a1 = 6.6;
C1 = 300;
C2 = 144;
C3 = 100;
C4 = 80;
C5 = 26;
Ub = 72;
U0 = 4;
Um = 94;
Rg = 180;
a  = 7.5;
b  = 1.772;
G = 0;
K = 50;
eps = 1;

%kick - uncomment for delta kicks
A = 1000;

%number of iterations - uncomment for delta kicks
N = 20;

%inter-kick time
T = 200;
TT = 1000;

%Final time - use only for square pulses
% TT = K*T-1;


%initial conditions
y11_init = 0;
y12_init = 0;
y13_init = 18000;
y14_init = 0;
y15_init = 0;
y16_init = 0;

%Uncomment the following if you are using delta kicks
%vectors to store glucose and time
Y = [];
tt = [];

Z = [];



for kk = 1:N
    [t,y] = ode23s(@Ultradian,[(kk-1)*T kk*T],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);

    if kk > 7
    Z = [Z;y(end,3)];
    end

    
    %implementing delta kick
    y(end,3) = y(end,3) + A;
    
    %storing solutions
    Y = [Y;y];
    tt = [tt;t];
    
    %modifying initial data
    y11_init = Y(end,1);
    y12_init = Y(end,2);
    y13_init = Y(end,3);
    y14_init = Y(end,4);
    y15_init = Y(end,5);
    y16_init = Y(end,6);

    
end

% [t,y] = ode23s(@Ultradian,[N*T ,TT],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);
% Y = [Y;y];
% tt = [tt;t];

%Uncomment the following if you are using square pulses
% [t,y] = ode23s(@Ultradian,[0,TT],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);
% 
% tt = 0:0.01:TT-1;
% y2 = 0;
% for n = 1:K
%    %y2 = y2 + (A/eps)*(heaviside(tt - n*T) - heaviside(tt - n*T-eps)); 
%    y2 = y2 + (A/(eps*sqrt(pi)))*exp(-((tt-n*T)/eps).^2);
% end

%Uncomment for delta pulses
figure(1)
plot(tt,Y(:,3),'k','LineWidth',3)
set(gca,'fontsize',20)
ylabel('glucose')
xlabel('time (min)')

r = [0.8500 0.3250 0.0980];

yy = Y(:,3);
mm = mean(Z);


figure(2)
histogram(Y(:,3),50,'FaceColor',r,'Normalization','probability')
set(gca,'fontsize',20)
ylabel('glucose')
hold on
line([mm,mm],[0 0.1])

%Uncomment for square pulses
% figure(1)
% plot(t,y(:,3),'k','LineWidth',3)
% set(gca,'fontsize',20)
% ylabel('glucose')
% xlabel('time')

% %Uncomment to see time series of square pulse
% figure(2)
% plot(tt,y2,'k','LineWidth',3)
% set(gca,'fontsize',20)
% ylabel('square pulse')
% xlabel('time')

