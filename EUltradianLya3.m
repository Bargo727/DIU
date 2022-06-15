clear;

format long

global E Vp Vi Vg tp ti td Rm Rg C1 C2 C3 C4 C5 k a1 Ub U0 Um a b G K T 
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
for Rg = [120 140 180 220]
a  = 7.5;
b  = 1.772;
G = 0;
%K = 1;
%T = 200;

%vector for values of inter-kick times we study
 TT = 1:50;
 Y = length(TT);

%initial difference between two trajectories to compute Lyapunov exponents
d0 = 1E-8;

%size of kick
AA = 1000;

%uncomment here if you want to investigate how Lyapunov exponents depend on
%kick size
%AA = 10:50:1060;
%Y = length(AA);

%number of iterations
N = 100;

%vector to store Lyapunov exponents
LL = zeros(Y,1);





for jj = 1:Y
%setting inter-kick time; comment for breakfast, lunch, dinner
T = TT(jj); 

%A = AA(jj);

%temp vector to store Lyapunov exponents so we can compute average
lya = zeros(N-1,1);

%td = TD(jj);

%initial conditions for solution y1
y11_init = 0;
y12_init = 0;
y13_init = 0;
y14_init = 0;
y15_init = 0;
y16_init = 0;

%initial conditions for solution y2
y21_init = d0;
y22_init = 0;
y23_init = 0;
y24_init = 0;
y25_init = 0;
y26_init = 0;


for kk = 2:N
    %comment two lines for breakfast, lunch, dinner
    %ll = -log(rand(1,1))*T;
    ll = T;
    
    
     [t1,y1] = ode23s(@Ultradian,[0 ll],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);
     [t2,y2] = ode23s(@Ultradian,[0 ll],[y21_init;y22_init;y23_init;y24_init;y25_init;y26_init]);
    
%     [t1,y1] = ode23s(@Ultradian,[0 1.5*T],[y11_init;y12_init;y13_init;y14_init;y15_init;y16_init]);
%     [t2,y2] = ode23s(@Ultradian,[0 1.5*T],[y21_init;y22_init;y23_init;y24_init;y25_init;y26_init]);
    
    
    %implementing kicks; comment for breakfast, lunch, dinner
      y1(end,3) = y1(end,3) + AA;
      y2(end,3) = y2(end,3) + AA;
    
     %new distance
    d = sqrt((y1(end,1)-y2(end,1))^2 + (y1(end,2)-y2(end,2))^2 + (y1(end,3)-y2(end,3))^2 + (y1(end,4)-y2(end,4))^2 + (y1(end,5)-y2(end,5))^2 + (y1(end,6)-y2(end,6))^2);
    
    %storing Lyapunov exponent
    lya(kk-1) = log(d/d0);
    
    
    %renormalizing trajectories
    y21new = y1(end,1) + (d0/d)*(y2(end,1)-y1(end,1));
    y22new = y1(end,2) + (d0/d)*(y2(end,2)-y1(end,2));
    y23new = y1(end,3) + (d0/d)*(y2(end,3)-y1(end,3));
    y24new = y1(end,4) + (d0/d)*(y2(end,4)-y1(end,4)); 
    y25new = y1(end,5) + (d0/d)*(y2(end,5)-y1(end,5)); 
    y26new = y1(end,6) + (d0/d)*(y2(end,6)-y1(end,6)); 
    
    y11_init = y1(end,1);
    y12_init = y1(end,2);
    y13_init = y1(end,3);
    y14_init = y1(end,4);
    y15_init = y1(end,5);
    y16_init = y1(end,6);

    y21_init = y21new;
    y22_init = y22new;
    y23_init = y23new;
    y24_init = y24new;
    y25_init = y25new;
    y26_init = y26new;
    
end

%computing mean Lyapunov exponent for the selected interkick time
LL(jj) = mean(lya);


end

figure(3)
plot(TT,LL,'-o','MarkerSize',10,'LineWidth',1)
xlabel('T')
ylabel('\Lambda_{max}')
set(gca,'fontsize',20)
hold on
end
zz = zeros(length(TT),1);

figure(3)
plot(TT,zz,'k--','LineWidth',3)
h = legend('R_g = 120','R_g = 140','R_g = 180','R_g = 220');
set(h,'box','off')