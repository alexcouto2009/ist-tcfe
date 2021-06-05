
%------------lab5-------------

R1 = 1000;
R2 = 150000;
R3 = 1000;
R4 = 1000;


C1 = 220e-9;
C2 = 110e-9;

fc = 1000;

fp = fopen("Values.tex","w");
fprintf(fp,"Vin & 1.0 sin(0 0.010 1000)\\\\ \\hline \n");
fprintf(fp,"R1 & %f\\\\ \\hline \n",R1);
fprintf(fp,"R2 & %f\\\\ \\hline \n",R2);
fprintf(fp,"R3 & %f\\\\ \\hline \n",R3);
fprintf(fp,"R4 & %f\\\\ \\hline \n",R4);
fprintf(fp,"C1 & %.11f\\\\ \\hline \n",C1);
fprintf(fp,"C2 & %.11f\\\\ \\hline \n",C2);
fclose(fp)

w0 = 2*pi*fc;

ZI = R1 + 1/(j*w0*C1);
ZO = R4/(1+j*w0*C2*R4);
Zout = 1/(1/R2+1/ZO);


Av = 1+R2/R3;

AH = R1*C1*j*w0/(1+R1*C1*j*w0);

AL = 1/(1+j*w0*C2*R4);

AT = Av*AH*AL;


Gain = 20*log10(AT);

fp = fopen("Impedances.tex","w");
fprintf(fp,"ZI & %f%fj\\\\ \\hline \n",real(ZI),imag(ZI));
fprintf(fp,"ZO & %f%fj\\\\ \\hline \n",real(Zout),imag(ZI));
fclose(fp)

fp = fopen("Gain.tex","w");
fprintf(fp,"Gain & %f\\\\ \\hline \n",Gain);
fclose(fp)

f = logspace(1,7,1000);

w = 2*pi*f;

Av1 = 1+R2/R3;

AH1 = R1*C1*j*w./(1+R1*C1*j*w);

AL1 = 1./(1+j*w*C2*R4);

AT1 = Av1.*AH1.*AL1;


gain = AT1;


figure 1
plot (log10(f), 20*log10(abs(gain)));
xlabel("log10 frequency[Hz]");
ylabel("Gain [DB]");
title("Frequency response");
print ("gain1.eps", "-depsc");

figure 2
plot (log10(f), 180/pi*angle(gain));
xlabel("log10 frequency[Hz]");
ylabel("Phase [degrees]");
title("Frequency response");
print ("phase1.eps", "-depsc");
