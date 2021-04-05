% First steep: Open the data.txt and get all values.

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
 
 B = [[1,0,0,0,0,0,0,0];
      [0,1,0,0,0,0,0,0];
      [0,-1/R1,1/R1+1/R3+1/R2,-1/R2,-1/R3,0,0,0];
      [0,0,-1/R2-Kb,1/R2,Kb,0,0,0];
      [0,0,-1/R3,0,1/R4+1/R5+1/R3,-1/R5,-1/R7,1/R7];
      [0,0,Kb,0,-1/R5-Kb,1/R5,0,0];
      [0,0,0,0,0,0,1/R6+1/R7,-1/R7];
      [0,0,0,0,1,0,Kd/R6,-1]]
      
 C = [0; Vs; 0; 0; 0; 0; 0; 0]     
 
 D = B\C;
 
 V0 = D(1,1);
 V1 = D(2,1);
 V2 = D(3,1);
 V3 = D(4,1);
 V5 = D(5,1);
 V6 = D(6,1);
 V7 = D(7,1);
 V8 = D(8,1);
 
 fp = fopen("tabela1.tex","w");

fprintf(fp,"V0 & %.11f\\\\ \\hline \n",V0);
fprintf(fp,"V1 & %.11f\\\\ \\hline \n",V1);
fprintf(fp,"V2 & %.11f\\\\ \\hline \n",V2);
fprintf(fp,"V3 & %.11f\\\\ \\hline \n",V3);
fprintf(fp,"V5 & %.11f\\\\ \\hline \n",V5);
fprintf(fp,"V6 & %.11f\\\\ \\hline \n",V6);
fprintf(fp,"V7 & %.11f\\\\ \\hline \n",V7);
fprintf(fp,"V8 & %.11f\\\\ \\hline \n",V8);

fclose(fp)

 fp = fopen("cir2.txt","w");
 
 fprintf(fp,"Vs 1 0 %.11f\n",Vs);      
 fprintf(fp,"R1 1 2 %.11f\n",R1);      
 fprintf(fp,"R2 2 3 %.11f\n",R2);    
 fprintf(fp,"R3 2 5 %.11f\n",R3);      
 fprintf(fp,"R4 5 0 %.11f\n",R4);       
 fprintf(fp,"R5 5 6 %.11f\n",R5);      
 fprintf(fp,"R6 0 7 %.11f\n",R6);      
 fprintf(fp,"R7 8 9 %.11f\n",R7);      
 fprintf(fp,"Hd 5 9 Vhd %.11f\n",Kd); 
 fprintf(fp,"Vhd 7 8 0\n");                  
 fprintf(fp,"Gb 6 3 2 5 %.11f\n",Kb);  
 fprintf(fp,"C1 6 9 %.11f\n",CD);      
 
 fclose(fp);
 

%-------------------- 2 Parte -----------------

 E = [[1,0,0,0,0,0,0,0];
      [0,1,0,0,0,0,0,0];
      [0,-1/R1,1/R1+1/R3+1/R2,-1/R2,-1/R3,0,0,0];
      [0,0,-1/R2-Kb,1/R2,Kb,0,0,0];
      [0,0,Kb-1/R3,0,1/R4+1/R3-Kb, 0,-1/R7,1/R7];
      [0,0,0,0,0,1,0,-1];
      [0,0,0,0,0,0,1/R6+1/R7,-1/R7];
      [0,0,0,0,1,0,Kd/R6,-1]]
      
 F = [0; 0; 0; 0; 0; V6-V8; 0; 0]     
 
 G = E\F;
 
 V0 = G(1,1);
 V1 = G(2,1);
 V2 = G(3,1);
 V3 = G(4,1);
 V5 = G(5,1);
 V6 = G(6,1);
 V7 = G(7,1);
 V8 = G(8,1);
 
 Ic = -(V6-V5)/R5 - Kb*(V2-V5);
 Req = (V6-V8)/Ic;
 
 tau = abs(CD*Req);
 
  fp = fopen("tabela2.tex","w");
  fprintf(fp,"Ic & %.11f\\\\ \\hline \n",Ic);
  fprintf(fp,"Req & %.11f\\\\ \\hline \n",Req);
  fprintf(fp,"Tau & %.11f\\\\ \\hline \n",tau);
  fprintf(fp,"V0 & %.11f\\\\ \\hline \n",V0);
  fprintf(fp,"V1 & %.11f\\\\ \\hline \n",V1);
  fprintf(fp,"V2 & %.11f\\\\ \\hline \n",V2);
  fprintf(fp,"V3 & %.11f\\\\ \\hline \n",V3);
  fprintf(fp,"V5 & %.11f\\\\ \\hline \n",V5);
  fprintf(fp,"V6 & %.11f\\\\ \\hline \n",V6);
  fprintf(fp,"V7 & %.11f\\\\ \\hline \n",V7);
  fprintf(fp,"V8 & %.11f\\\\ \\hline \n",V8);
  fclose(fp)
  
  fp = fopen("cir3.txt","w");
 
 fprintf(fp,"Vs 1 0 0\n");      
 fprintf(fp,"R1 1 2 %.11f\n",R1);      
 fprintf(fp,"R2 2 3 %.11f\n",R2);    
 fprintf(fp,"R3 2 5 %.11f\n",R3);      
 fprintf(fp,"R4 5 0 %.11f\n",R4);       
 fprintf(fp,"R5 5 6 %.11f\n",R5);      
 fprintf(fp,"R6 0 7 %.11f\n",R6);      
 fprintf(fp,"R7 8 9 %.11f\n",R7);      
 fprintf(fp,"Hd 5 9 Vhd %.11f\n",Kd); 
 fprintf(fp,"Vhd 7 8 0\n");                  
 fprintf(fp,"Gb 6 3 2 5 %.11f\n",Kb); 
 fprintf(fp,"Vx 6 9 8.678914\n"); 
       
 fclose(fp);
  
  
  
  %------------------ 3 Parte -------------------------
    
 
 
 t = 0:1e-6:20e-3;
 
 v6_n = V6*exp(-t./tau);
 
 figure(1);
 plot (t*1000, v6_n, "g");
 xlabel ("t[ms]");
 ylabel ("v6_n(t) [V]");
 print (figure(1), "v6_n.eps", "-depsc");
 
  fp = fopen("cir41.txt","w");
 
 fprintf(fp,"Vs 1 0 0\n");      
 fprintf(fp,"R1 1 2 %.11f\n",R1);      
 fprintf(fp,"R2 2 3 %.11f\n",R2);    
 fprintf(fp,"R3 2 5 %.11f\n",R3);      
 fprintf(fp,"R4 5 0 %.11f\n",R4);       
 fprintf(fp,"R5 5 6 %.11f\n",R5);      
 fprintf(fp,"R6 0 7 %.11f\n",R6);      
 fprintf(fp,"R7 8 9 %.11f\n",R7);      
 fprintf(fp,"Hd 5 9 Vhd %.11f\n",Kd); 
 fprintf(fp,"Vhd 7 8 0\n");                  
 fprintf(fp,"Gb 6 3 2 5 %.11f\n",Kb);  
 fprintf(fp,"C1 6 9 %.11f\n",CD);      
 
 fclose(fp);
  
 fp = fopen("cir42.txt","w");
 fprintf(fp, ".ic V(6)=%.11f V(9)=0",V6);
 fclose(fp);
 
 
 %------------------- 4 Parte -------------------------
 
  fp = fopen("cir51.txt","w");
 
 fprintf(fp,"Vs 1 0 0.0 ac 1.0 sin(0 1 1000)\n");      
 fprintf(fp,"R1 1 2 %.11f\n",R1);      
 fprintf(fp,"R2 2 3 %.11f\n",R2);    
 fprintf(fp,"R3 2 5 %.11f\n",R3);      
 fprintf(fp,"R4 5 0 %.11f\n",R4);       
 fprintf(fp,"R5 5 6 %.11f\n",R5);      
 fprintf(fp,"R6 0 7 %.11f\n",R6);      
 fprintf(fp,"R7 8 9 %.11f\n",R7);      
 fprintf(fp,"Hd 5 9 Vhd %.11f\n",Kd); 
 fprintf(fp,"Vhd 7 8 0\n");                  
 fprintf(fp,"Gb 6 3 2 5 %.11f\n",Kb);  
 fprintf(fp,"C1 6 9 %.11f\n",CD);      
 
 fclose(fp);
  
 fp = fopen("cir52.txt","w");
 fprintf(fp, ".ic V(6)=%.11f V(9)=0",V6);
 fclose(fp);
 
 
 Vs = exp(-pi/2*j);
 %Vs = 1;
 w = 2*pi*1000;
 
  H = [[1,0,0,0,0,0,0,0];
      [0,1,0,0,0,0,0,0];
      [0,-1/R1,1/R1+1/R3+1/R2,-1/R2,-1/R3,0,0,0];
      [0,0,-1/R2-Kb,1/R2,Kb,0,0,0];
      [0,0,-1/R3,0,1/R4+1/R5+1/R3,-1/R5-j*w*CD,-1/R7,1/R7+j*w*CD];
      [0,0,Kb,0,-1/R5-Kb,1/R5+j*w*CD,0,-j*w*CD];
      [0,0,0,0,0,0,1/R6+1/R7,-1/R7];
      [0,0,0,0,1,0,Kd/R6,-1]]
      
 S = [0; Vs; 0; 0; 0; 0; 0; 0]     
 
 U = H\S;
 
 V0 = U(1,1)
 V1 = U(2,1)
 V2 = U(3,1)
 V3 = U(4,1)
 V5 = U(5,1)
 V6 = U(6,1)
 V7 = U(7,1)
 V8 = U(8,1)
 
 
  fp = fopen("tabela3.tex","w");

fprintf(fp,"V0 & %.11f+(%.11f)j\\\\ \\hline \n",real(V0),imag(V0));
fprintf(fp,"V1 & %.11f+(%.11f)j\\\\ \\hline \n",real(V1),imag(V1));
fprintf(fp,"V2 & %.11f+(%.11f)j\\\\ \\hline \n",real(V2),imag(V2));
fprintf(fp,"V3 & %.11f+(%.11f)j\\\\ \\hline \n",real(V3),imag(V3));
fprintf(fp,"V5 & %.11f+(%.11f)j\\\\ \\hline \n",real(V5),imag(V5));
fprintf(fp,"V6 & %.11f+(%.11f)j\\\\ \\hline \n",real(V6),imag(V6));
fprintf(fp,"V7 & %.11f+(%.11f)j\\\\ \\hline \n",real(V7),imag(V7));
fprintf(fp,"V8 & %.11f+(%.11f)j\\\\ \\hline \n",real(V8),imag(V8));

fclose(fp)

 
 t = 0:1e-6:20e-3;
 
 phy = angle(V6);
 V6_m = sqrt(imag(V6).^2+real(V6).^2);
 
 v6_f = real(V6_m*exp(j*2*pi*1000*t)*exp(j*phy));
 
 %v6_g = real(V6*exp(j*2*pi*1000*t));
 
 figure(2);
 plot (t*1000, v6_f, "b");
 xlabel ("t[ms]");
 ylabel ("v6_f(t) [V]");
 print (figure(2), "v6_f.eps", "-depsc");
 
 %------------------------ 5 parte --------------------------
 
 v6_fi = v6_f + v6_n;
 Vs_fi = sin(2*pi*1000*t);
 
 figure(3);
 plot (t*1000, v6_fi, "b");
 hold on;
 plot (t*1000, Vs_fi, "r");
 hold on;
 xlabel ("t[ms]");
 ylabel ("v6(t) vs(t) [V]");
 
 t1 = -5e-3:1e-6:0;
 
 vs_in = A(8,1)+0*t1;
 v6_in = D(6,1)+0*t1;
 plot (t1*1000, v6_in, "b");
 hold on;
 plot (t1*1000, vs_in, "r");
 xlabel ("t[ms]");
 ylabel ("v6(t) vs(t) [V]");
 print (figure(3), "v6_vs.eps", "-depsc");

 %-------------------------- 6 parte ------------------------

 syms f
 
 
  %Vs = exp(-pi/2*j);
 Vs = 1;
 %w = 2*pi*1000;
 
  H = [[1,0,0,0,0,0,0,0];
      [0,1,0,0,0,0,0,0];
      [0,-1/R1,1/R1+1/R3+1/R2,-1/R2,-1/R3,0,0,0];
      [0,0,-1/R2-Kb,1/R2,Kb,0,0,0];
      [0,0,-1/R3,0,1/R4+1/R5+1/R3,-1/R5-j*2*pi*f*CD,-1/R7,1/R7+j*2*pi*f*CD];
      [0,0,Kb,0,-1/R5-Kb,1/R5+j*2*pi*f*CD,0,-j*2*pi*f*CD];
      [0,0,0,0,0,0,1/R6+1/R7,-1/R7];
      [0,0,0,0,1,0,Kd/R6,-1]]
      
 S = [0; Vs; 0; 0; 0; 0; 0; 0]     
 
 U = H\S;
 
 V0 = U(1,1)
 V1 = U(2,1)
 V2 = U(3,1)
 V3 = U(4,1)
 V5 = U(5,1)
 V6 = U(6,1)
 V7 = U(7,1)
 V8 = U(8,1)
 

 

 hp = function_handle(V6-V8);
 
 
 f = 0.1:10:1e6;
 vp = hp(f)
 figure(4);
 plot(log10(f),20*log10(abs(vp)),"b");
 xlabel ("log10f[Hz]");
 ylabel ("mag_vc [db]");
 print (figure(4), "mag_vc.eps", "-depsc");
 
 figure(5)
 plot(log10(f),180/pi*angle(vp)-90,"b");
 xlabel ("log10f[Hz]");
 ylabel ("phase_vc [degrees]");
 print (figure(5), "phase_vc.eps", "-depsc");
 
 hp1 = function_handle(V6);
 
 
 f = 0.1:10:1e6;
 vp1 = hp1(f)
 figure(6);
 plot(log10(f),20*log10(abs(vp1)),"b");
 xlabel ("log10f[Hz]");
 ylabel ("mag_v6 [db]");
 print (figure(6), "mag_v6.eps", "-depsc");
 
 figure(7)
 plot(log10(f),180/pi*angle(vp1)-90,"b");
 xlabel ("log10f[Hz]");
 ylabel ("phase_v6 [degrees]");
 print (figure(7), "phase_v6.eps", "-depsc");
 
 vs1 = 1+0*j;
 f1 = -1:1:6;
 
 figure(8);
 plot(f1,20*log10(abs(vs1)),"b");
 xlabel ("log10f[Hz]");
 ylabel ("mag_vs [db]");
 print (figure(8), "mag_vs.eps", "-depsc");
 
 figure(9)
 plot(f1,180/pi*angle(vs1)-90,"b");
 xlabel ("log10f[Hz]");
 ylabel ("phase_vs [degrees]");
 print (figure(9), "phase_vs.eps", "-depsc");
 
 
 %t2 = func2str(hp);
 
 
 %h = erase(t2, "@(f)");
 
 %f = 0.1:100:1e6-1;
 
 %p = str2num(h)
 
 
 
 %h
 
 %fp = hp(linspace(0,2*pi*1000,1))
 
% atan(imag(fp)/real(fp))
 
 %fp = hp(linspace(0.1,1e6,1e4));
 
 
 %i = 1;
 %while(i<1e3+1)
 %t(i,1) = atan(imag(fp(i))/real(fp(i)));
 %i++;
 %endwhile
 
 
 
 %t = -56712366161413625469996 * pi * (-1331082023190436152103774585367989915911204000 * pi ^ 2 * f + 188929531079914660062468551168647196338192000 * pi * f - 81505266955137527099762749200 * 1i * pi ^ 2 * f + 11568597275071393242890881600 * 1i * pi * f - 47981865812651823712314786593344 * pi - 11042045753851301928075273598200 * pi ^ 2 + 41311857231967148997132090528400 + 9357071730372857795893039717695 * pi ^ 3 - 152812578073737111703324197243996217620981072150 * 1i * pi ^ 3 - 674673828580290650852587502876134340651733508000i + 180330292155080217836997612590853816167480334000 * 1i * pi ^ 2 + 783603335199319005821591580335691280523173617280 * 1i * pi) ./ (-531232781563812296786420850369893093593459084128055952820551113453200 * 1i * pi ^ 4 * f - 3281572718468381161626680640186744340771742186586676062239573306797820 * 1i * pi ^ 2 *f + 1371626427278011047867748478877571874126601372273216198712995716252560 * 1i * pi * f + 2450490771540569906579821494051951789266326916832478959962778468048100 * 1i * pi ^ 3 * f - 83149164390493760417971353657990031153447757021230829519917353013830300 * pi ^ 3 - 513635526452372484638021264739670397920050518132748644004154563478489905 * pi + 214688541901259169069139653518929350199081208446481658576929009361211740 +383553626717855886313475628727531316874273548914484323527681472514066775 * pi ^ 2)
 
 % f = 0.1:100:1e6;
 
 %figure(4)
 %plot(f, h, "r");
 
 %figure(4)
 %plot(log10(f), 20*log10(fp));
 
 
 %figure(5)
 %plot(log10(f), angle(fp));
 
 %Tf = [1./(1+j*2*pi*f*-Req*CD)];
 %    V6_fre = Tf*exp(-pi/2);
  %   f(11)
  %   Tf(11)
 
 %figure (4)
 %plot(f, 20*log10(abs(V6_fre)));
 
 %figure(5)
 %plot(f, angle(V6_fre));
 