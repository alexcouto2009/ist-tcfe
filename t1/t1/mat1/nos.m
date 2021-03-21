
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

V0 = 0 

A = [[1,0,0,0,0,0,0];
     [-1/R1, 1/R1 + 1/R3 + 1/R2, -1/R2, -1/R3, 0,0,0];
     [0, -Kb - 1/R2, 1/R2, Kb, 0, 0, 0];
     [0, Kb, 0, -Kb-1/R5, 1/R5, 0,0];
     [0,0,0,0,0, 1/R6 + 1/R7, -1/R7];
     [0,0,0,1,0, Kc/R6, -1];
     [0, -1/R3, 0, 1/R3 + 1/R5 + 1/R4, -1/R5, -1/R7, 1/R7]]

B = [Va; 0; 0; Id; 0; 0; -Id]

C = A\B


V1 = C(1,1)
V2 = C(2,1)
V3 = C(3,1)
V4 = C(4,1)
V5 = C(5,1)
V6 = C(6,1)
V7 = C(7,1)

Ic = -V6/R6

Vc = Kc * Ic

Vb = V2-V4

Ib = Kb * Vb

fp = fopen("tabela2.tex","w");
fprintf(fp, 'V0 & %f\\\\ \\hline\n',V0);
fprintf(fp, 'V1 & %f\\\\ \\hline\n',V1);
fprintf(fp, "V2 & %f\\\\ \\hline\n ",V2);
fprintf(fp, "V3 & %f\\\\ \\hline\n",V3);
fprintf(fp, "V4 & %f\\\\ \\hline\n",V4);
fprintf(fp, "V5 & %f\\\\ \\hline\n",V5);
fprintf(fp, "V6 & %f\\\\ \\hline\n",V6);
fprintf(fp, "V7 & %f\\\\ \\hline\n",V7);
fprintf(fp, "Ic & %f\\\\ \\hline\n",Ic);
fprintf(fp, "Ib & %f\\\\ \\hline\n",Ib); 
fclose(fp);

