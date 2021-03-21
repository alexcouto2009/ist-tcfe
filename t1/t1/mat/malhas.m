
R1 = 1.03055897104e3
R2 = 2.07633317652e3
R3 = 3.11228971368e3
R4 = 4.1814130542e3
R5 = 3.06747464193e3
R6 = 2.01035149284e3
R7 = 1.00587624853e3
Va = 5.1951993125
Id = 1.04139652596e-3

Kb = 7.11172371179e-3 % S 
Kc = 8.02979201109e3 % Ohm


A = [[1,0,0,0];[0,1-Kb*R3,Kb*R3,0];[0,-R3,R3+R4+R1,-R4];[0,0,-R4,R6+R7-Kc+R4]]
B = [Id; 0; -Va; 0]

C = A\B

I_a = C(3,1)
I_b = C(2,1)
I_c = C(4,1)
I_d = C(1,1)

Vb = (I_b-I_a)*R3
Ic = I_c
Ib = I_b
Ib = Kb*Vb
Vc = Kc*Ic 


fp = fopen("tabela1.tex","w");

fprintf(fp,"Ia & %f\\\\ \\hline \n",I_a);
fprintf(fp,"Ib & %f\\\\ \\hline \n",I_b);
fprintf(fp,"Ic & %f\\\\ \\hline \n",I_c);
fprintf(fp,"Id & %f\\\\ \\hline \n",I_d);

fprintf(fp,"Vb & %f\\\\ \\hline \n",Vb);
fprintf(fp,"Ic & %f\\\\ \\hline \n",Ic);
fprintf(fp,"Ib & %f\\\\ \\hline \n",Ib);
fprintf(fp,"Vc & %f\\\\ \\hline \n",Vc);

fclose(fp)
