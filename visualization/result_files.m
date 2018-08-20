k=0;
for i=1:9
   m(k+1:k+6,1)=(j(i,:))'; 
   m(k+1:k+6,2)=(mia(i,:))'; 
   m(k+1:k+6,3)=(cdi(i,:))'; 
   m(k+1:k+6,4)=(smi(i,:))'; 
   m(k+1:k+6,5)=(dbi(i,:))'; 
   m(k+1:k+6,6)=(wcbcr(i,:))'; 
   k=k+6;
end
filename = 'results_attr1';
xlswrite(filename,m,1,'A1:F54')