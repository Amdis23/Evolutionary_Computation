function f = ProductionPlan(x)
ca = 5;
[Bcase,R1,R2,rm1,rm2,SP,l,m,h,ih,il,im,cl,cm,ch,product] = ProductionPlanningData(ca);
Npro = length(l);
pIC = 0; PDH = zeros(Npro,1); pR1C = 0; pR2C = 0;
PC = zeros(Npro,1); IC = zeros(Npro,1);
Xtrue = x';
for j = 1:Npro
    if Xtrue(j) >= l(j) && Xtrue(j) <= m(j)
        PC(j) = ((cm(j) - cl(j))/(m(j) - l(j)))*(Xtrue(j) - l(j)) + cl(j);
        IC(j) = ((im(j) - il(j))/(m(j) - l(j)))*(Xtrue(j) - l(j)) + il(j);
    elseif Xtrue(j) > m(j) && Xtrue(j) <= h(j)
        PC(j) = ((ch(j) - cm(j))/(h(j) - m(j)))*(Xtrue(j) - m(j)) + cm(j);
        IC(j) = ((ih(j) - im(j))/(h(j) - m(j)))*(Xtrue(j) - m(j)) + im(j);
    elseif 0< Xtrue(j) &&  Xtrue(j)< l(j)
        PDH(j) = 10^5;
        Xtrue(j) = 0;
    end
end
SPtotal = (Xtrue.*SP);
PC = sum(PC); IC = sum(IC);
profit = sum(SPtotal) - sum(PC);

R2C = (Xtrue.*rm2);   R1C = (Xtrue.*rm1); 
       
    if sum(IC) > Bcase
        pIC = (sum(IC) - Bcase)^2;
    end
    
    if sum(R1C) > R1
        pR1C = (sum(R1C) - R1)^2;
    end
    
    if sum(R2C) > R2
        pR2C = (sum(R2C) - R2)^2;
    end


f = -profit + 10^15*(sum(PDH) + pIC + pR1C + pR2C);
