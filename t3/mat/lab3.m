clear;
close all;


f=50;
w=2*pi*f;
R=12.1e3;
C=15e-6;
A=14.8;
t= 20e-3:1e-4:220e-3;

fp = fopen("Circuit.tex","w");
fprintf(fp,"Frequency & %.11f\\\\ \\hline \n",f);
fprintf(fp,"Transformer n:1 ratio & 15.54:1\\\\ \\hline \n");
fprintf(fp,"Transformer amplitude & %.11f\\\\ \\hline \n",A);
fprintf(fp,"R & %.11f\\\\ \\hline \n",R);
fprintf(fp,"C & %.11f\\\\ \\hline \n",C);
fprintf(fp,"Diodes in voltage regulator & 21\\\\ \\hline \n");
fclose(fp)

Vs = A*cos(w*t);
figure;
plot(t,Vs);
%legend("Input voltage");
title("Input voltage V_s(t)");
xlabel('t[ms]');
ylabel('Voltage[V]');
print ("vs.eps", "-depsc");


vOhr = zeros(1, length(t));
vO = zeros(1, length(t));

%Envelope detec solution
tOFF = 1/w * atan(1/w/R/C);
VOnexp = (A-1.4)*cos(w*tOFF)*exp(-(t-tOFF)/(R*C));

for i=1:length(t)
  if (Vs(i) > 0)
    vOhr(i) = Vs(i)-1.4;
  else
    vOhr(i) = -Vs(i)-1.4;
  endif
endfor

figure;
%plot(t,vOhr);
%hold();

for i=1:length(t)
  if t(i) < tOFF
    vO(i) = vOhr(i);
  elseif (VOnexp(i) > vOhr(i))
    vO(i) = VOnexp(i);
  elseif VOnexp(i)<-vOhr(i)
    vO(i)= -VOnexp(i);
  else 
    vO(i) = vOhr(i);
    tOFF=tOFF+1/f/2
    VOnexp = (A-1.4)*cos(w*tOFF)*exp(-(t-tOFF)/R/C);
  endif
endfor

plot(t,vO);
%legend("Envelope")
title("Output voltage from envelope detector")
xlabel('t[ms]');
ylabel('Voltage[V]');
print ("Vc.eps", "-depsc");


%------------------------------------------

%vS=mean(vO)+0*t;
vS=vO;
mean(vO)

%%solve circuit with accurate model

function f = f(vD,vS,R)
Is = 1e-14;
VT=250e-4;
f = vD+R*Is * (exp(vD/VT/21)-1) - vS;
endfunction

function fd = fd(vD,R)
Is = 1e-14;
VT=250e-4;
fd = 1 + R*Is/21/VT * (exp(vD/VT/21)-1);
endfunction

function vD_root = solve_vD (vS, R)
  delta = 1e-6;
  x_next = 0.65;
  do 
    x=x_next;
    x_next = x  - f(x, vS, R)/fd(x, R);
  until (abs(x_next-x) < delta)

  vD_root = x_next;
endfunction


VO = zeros(1,length(t));

for i=1:length(t)
  vD = solve_vD  (vS(i), R);
  VO(i) = vD;
endfor

mean(VO)


figure
plot(t, VO,"r");
%axis([0 200e-3 0 15]);
%legend("Output voltage V_o(t)");
title("Output voltage V_o(t)");
xlabel('t[ms]');
ylabel('Voltage[V]');
print ("vo.eps", "-depsc");

figure
plot(t, VO-12,"r");
axis([0 220e-3 -0.2 0.2]);
%legend("Output voltage V_o(t)-12");
title("Difference between output voltage V_o(t) and the desired output");
xlabel('t[ms]');
ylabel('Voltage[V]');
print ("vo_dif.eps", "-depsc");

fp = fopen("Average.tex","w");
fprintf(fp,"Average & %.11f\\\\ \\hline \n",mean(VO));
fclose(fp);

max(VO)
min(VO)
ripple = abs(max(VO)-min(VO));

fp = fopen("ripple.tex","w");
fprintf(fp,"Max & %.11f\\\\ \\hline \n",max(VO));
fprintf(fp,"Min & %.11f\\\\ \\hline \n",min(VO));
fprintf(fp,"Ripple & %.11f\\\\ \\hline \n",ripple);
fclose(fp);


%figure
%plot(t, vD)
%title("Output voltage v_o(t)")
%xlabel ("t[ms]")
%ylabel ("v_o[V]")
%print ("vo.eps", "-depsc");

%VT=258.65e-4;
%Is = 1e-14;
%Vf = vO-vS;

%rd = 21*VT/(Is*exp(vD/21/VT))
%v0_ac=rd/(R+rd)*Vf;


%plot(t, v0_ac+vD,"g");


%figure 
%plot (t, v0_ac+vD);


%max(v0_ac+vD)
%min(v0_ac+vD)


