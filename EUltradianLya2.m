clear;

global E Vp Vi Vg tp ti td Rm Rg C1 C2 C3 C4 C5 k a1 Ub U0 Um a b G 
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

format long
T = 200;
     
N = 50;
lya = zeros(N-1,1);
y11_init = 0;
y12_init = 0;
y13_init = 0;
y14_init = 0;
y15_init = 0;
y16_init = 0;

tt = [];
yy = [];
zz = [];
xx = [];
t_pre = [];
y_pre = [];
z_pre = [];
x_pre = [];

kick_return_x = [];
kick_return_y = [];
kick_return_z = [];



for kk = 2:N
    %ll = -log(rand(1,1))*T;
    ll = T;
    [t1,y1] = ode23s(@Ultradian,[0 ll],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);
    
    if(kk == 2)
        tt = t1;
    else
        tt = [tt;t1+tt(end)];
    end
    yy = [yy;y1(:,1)];
    zz = [zz;y1(:,3)];
    xx = [xx;y1(:,2)];
    
    t_pre = [t_pre;tt(end)];
    y_pre = [y_pre;yy(end)];
    x_pre = [x_pre;xx(end)];
    z_pre = [z_pre;zz(end)];
    
    kick_return_x = y1(:,2);
    kick_return_y = y1(:,1);
    kick_return_z = y1(:,3);
    
    y11_init = y1(end,1);
    y12_init = y1(end,2);
    y13_init = y1(end,3) + 1000;
    y14_init = y1(end,4);
    y15_init = y1(end,5);
    y16_init = y1(end,6);

    
end

figure(5)
subplot(2,1,1)
plot(tt,zz,'k','LineWidth',3)
axis([0 T*N 8000 18000])
set(gca,'fontsize',20)
xlabel('time')
ylabel('glucose')


subplot(2,1,2)
plot3(x_pre,y_pre,z_pre,'b*',kick_return_x,kick_return_y,kick_return_z,'k-','LineWidth',2)
%axis([30 110 8000 14000])
set(gca,'fontsize',20)
xlabel('interstitial insulin')
ylabel('plasma insulin')
zlabel('glucose')


