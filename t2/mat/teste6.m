 pkg load symbolic
 
 
 fp = fopen("data.txt","r");
 A = fscanf(fp,"%f", 11);
 fclose(fp);
 
 R1 = A(1,1) * 1e3;
 R2 = A(2,1) * 1e3; 
 R3 = A(3,1) * 1e3;
 R4 = A(4,1) * 1e3;
 R5 = A(5,1) * 1e3;
 R6 = A(6,1) * 1e3;
 R7 = A(7,1) * 1e3;
 Vs = A(8,1);
 CD  = A(9,1) * 1e-6;
 Kb = A(10,1) * 1e-3;
 Kd = A(11,1) * 1e3;

 %----------------------------------------
 
syms w
syms pi
pi = 3.14;
Vs = 1;


  H = [[1,0,0,0,0,0,0,0];
      [0,1,0,0,0,0,0,0];
      [0,-1/R1,1/R1+1/R3+1/R2,-1/R2,-1/R3,0,0,0];
      [0,0,-1/R2-Kb,1/R2,Kb,0,0,0];
      [0,0,-1/R3,0,1/R4+1/R5+1/R3,-1/R5-j*w*CD,-1/R7,1/R7+j*w*CD];
      [0,0,Kb,0,-1/R5-Kb,1/R5+j*w*CD,0,-j*w*CD];
      [0,0,0,0,0,0,1/R6+1/R7,-1/R7];
      [0,0,0,0,1,0,Kd/R6,-1]];
      
      
S = [0; Vs; 0; 0; 0; 0; 0; 0];     
 
 U = H\S;
 
 V0 = U(1,1);
 V1 = U(2,1);
 V2 = U(3,1);
 V3 = U(4,1);
 V5 = U(5,1);
 V6 = U(6,1);
 V7 = U(7,1);
 V8 = U(8,1);

 hp= function_handle(V6-V8);
 tye = function_handle(V8)

w=0.1:100:1e6;
vp = tye(w);
%figure(4);
%plot(w,abs(vp),"b");

figure(5);
plot(w,angle(vp),"r");

%Req=3060;
%T = 1 ./(1 + j*w*Req*CD);

%figure(6);
%plot (w, angle(T));
%xlabel ("w[rad/s]");
%ylabel ("angle");

%figure(7);
%plot(w,angle(T)-angle(vp),"r");
%abs(T(62))
%w(62)

%figure(8);
%plot(w,abs(T),"b");

%figure(9);
%plot (log10(w/2/pi), 180/pi*angle(T),"b");
%hold on;
%plot (log10(w/2/pi), 180/pi*angle(vp),"r");