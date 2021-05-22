%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
RE1=100
RC1=900
RB1=80000
RB2=20000
VBEON=0.7
VCC=12
RS=100

RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1


gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)

AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=0
AV1 = RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AV1simple = gm1*RC1/(1+gm1*RE1)

RE1=100

%ZI1 = ((ro1+RC1+RE1)*(RB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)

ZI1 = 1/(1/rpi1+1/RB1+1/RB2)

ZX = ro1*((RB+rpi1)*RE1/(RB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RB)+1/RE1+gm1*rpi1/(rpi1+RB)))

ZO1 = 1/(1/ZX+1/RC1)

Z01new = 1/(1/RC1+1/ro1)

%newgain = (-gm1*1/RB)/(1/RB+1/rpi1)*1/(1/ro1+1/RC1)

newgain1 = -gm1*1/(1/ro1+1/RC1)*1/(1+RS*(1/RB+1/rpi1))

fp = fopen("Values.tex","w");
fprintf(fp,"Vcc & %f\\\\ \\hline \n",VCC);
fprintf(fp,"Vin & 10e-2sin(2*pi*f*t)\\\\ \\hline \n");
fprintf(fp,"Rin & %f\\\\ \\hline \n",RS);
fprintf(fp,"R1 & %f\\\\ \\hline \n",RB1);
fprintf(fp,"R2 & %f\\\\ \\hline \n",RB2);
fprintf(fp,"Rc & %f\\\\ \\hline \n",RC1);
fprintf(fp,"Re & %f\\\\ \\hline \n",RE1);
fprintf(fp,"Rout & 1000\\\\ \\hline \n");
fprintf(fp,"Cin & 1e-3\\\\ \\hline \n");
fprintf(fp,"Cb & 5e-3\\\\ \\hline \n");
fprintf(fp,"Co & 1e-3\\\\ \\hline \n");
fclose(fp)



%ouput stage
BFP = 227.3
VAFP = 37.2
RE2 = 1000
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2


gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = gm2/(gm2+gpi2+go2+ge2)



ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)


newZI2 = 1/(gpi2*(1-(gpi2+gm2)/(gpi2+ge2+gm2+go2)))

newgain2 = (gm2+gpi2)/(gm2+gpi2+go2+ge2)

ZO2 = 1/(gm2+gpi2+go2+ge2)

ZI = ZI1
ZO = 1/(gm2+1/RE2)


newZO = 1/(go2+gm2*(1/gpi2)/(1/gpi2+Z01new)+ge2+1/(1/gpi2+Z01new))

newgainto = (1/(1/gpi2+Z01new)+(gm2*1/gpi2)/(1/gpi2+Z01new))/(1/(1/gpi2+Z01new)+ge2+go2+(gm2*1/gpi2)/(1/gpi2+Z01new))*newgain1


fp = fopen("OP.tex","w");
fprintf(fp,"VCE-VBE & %.5f\\\\ \\hline \n",VCE-VBEON);
fprintf(fp,"VEC-VEB & %.5f\\\\ \\hline \n",VO2-VEBON);
fclose(fp)

fp = fopen("Stage1.tex","w");
fprintf(fp,"ZI1 & %.5f\\\\ \\hline \n",ZI1);
fprintf(fp,"ZO1 & %.5f\\\\ \\hline \n",Z01new);
fprintf(fp,"Gain1 & %.5f\\\\ \\hline \n",20*log10(newgain1));
fclose(fp)

fp = fopen("Stage2.tex","w");
fprintf(fp,"ZI2 & %.5f\\\\ \\hline \n",newZI2);
fprintf(fp,"ZO2 & %.5f\\\\ \\hline \n",ZO2);
fprintf(fp,"Gain2 & %.5f\\\\ \\hline \n",20*log10(newgain2));
fclose(fp)



%incremental analysis

f = logspace(1,7,1000);


Vin1 = 10e-3*sin(2*pi*f);


figure 1
plot (log10(f), 20*log10(newgain1));
xlabel("log10 frequency[Hz]");
ylabel("Gain stage 1[DB]");
title("Gain in commom emmiter stage");
print ("gain1.eps", "-depsc");


figure 2
plot (log10(f), 20*log10(newgain2));
xlabel("log10 frequency[Hz]");
ylabel("Gain stage 2[DB]");
title("Gain in output stage");
print ("gain2.eps", "-depsc");


gaint1 = newgain1*newgain2

%A = [[1/(RB+RS)+1/rpi1,0,0];
%    [gm1,1/ro1+1/RC1+gpi2,-gpi2];
%    [0, -gm2-gm2, ge2 + 2*gm2 + go2]];
    
%B = [10e-2/(RB+RS);0;0];

%C = A\B;

%gaint2 = C(3,1)/10e-2

figure 3
plot (log10(f), 20*log10(newgainto));
xlabel("log10 frequency[Hz]");
ylabel("Gain stage 2[DB]");
title("Total Gain");
print ("gaint.eps", "-depsc");

fp = fopen("Final.tex","w");
fprintf(fp,"ZI & %.5f\\\\ \\hline \n",ZI1);
fprintf(fp,"ZO & %.5f\\\\ \\hline \n",newZO);
fprintf(fp,"Gainapprox & %.5f\\\\ \\hline \n",20*log10(gaint1));
fprintf(fp,"Gain & %.5f\\\\ \\hline \n",20*log10(newgainto));
fclose(fp)



