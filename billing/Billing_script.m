% This script computes the Cost Reduction/Peak Reduction for each cluster
% of the Dataset3

%Use equal rates for each three behaviours 
%for i=1:5
%    [CR1(:,i),PR1(:,i),CR_PER1(:,i),PR_PER1(:,i)]=Billing(average_plot3_not_norm,idx3,ci,i*2,[0.333333,0.333333,0.333333]);
%    CR_PR1(:,i)=CR1(:,i)./PR1(:,i);
%end

%CR_PR1=floor(CR_PR1*1000)/1000;

%Use the rates from the pilot from Netherland
%for i=1:5
%    [CR2(:,i),PR2(:,i),CR_PER2(:,i),PR_PER2(:,i)]=Billing(average_plot3_not_norm,idx3,ci,i*2,[0.1,0.55,0.35]);
%    CR_PR2(:,i)=CR2(:,i)./PR2(:,i);
%end

%CR_PR2=floor(CR_PR2*1000)/1000;

%Use the rates from the pilot from Canada
k=0.8;
for i=1:5
    c=0.07;
    if i==1 || i==2
        a=0.1;
    else
        a=0.9;
    end
    [CR3(:,i),PR3(:,i),CR_PER3(:,i),PR_PER3(:,i),bill,total_plot,new_plot]=Billing(average_plot3_not_norm,idx3,ci,i*2,[0.03,0.72,0.25],a,c);
    CR_PR3(:,i)=CR3(:,i)./PR3(:,i);
end

CR_PR3=floor(CR_PR3*1000)/1000;