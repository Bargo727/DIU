clear;

global E Vp Vi Vg tp ti td Rm Rg C1 C2 C3 C4 C5 k a1 Ub U0 Um a b G T K eps A
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
A = 1500;
K = 20;
eps = 1;

T = 200;

[t,y] = ode23s(@Ultradian,[0 4000],[0;0;0;0;0;0]);

figure(1)
plot(t,y(:,3),'LineWidth',4)
set(gca,'fontsize',20)
xlabel('time (minutes)')
ylabel('glucose')

figure(2)
plot(y(:,1), y(:,3),'LineWidth',4)
set(gca,'fontsize',20)
xlabel('plasma insulin')
ylabel('glucose')



