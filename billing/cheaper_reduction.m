function [new_plot] = cheaper_reduction(total_plot,bill,old_price,limits1,limits2,limits1_valley,limits2_valley,a,c)
%% Input arguments
%total_plot->1xN array, where N=number of measurements. Contains the sum of 
%       the average plots of the
%       consumers that belong to each cluster
%bill->1xN array that contains the new tariffs for each consumer
%old_price->the basic price before the application of the new tariff
%limits1->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region begins.
%limits2->vector that contains the indexes of the values of the total plot
%       that shows each point from where a peak region ends.
%limits1_valley->vector that contains the indexes of the values of the 
%       total plot that shows each point from where a valley region begins.
%limits2_valley->vector that contains the indexes of the values of the 
%       total plot that shows each point from where a valley region ends.
%
%% Output arguments
%new_plot->the new average plot of the cluster that is created when all the
%       consumers that belong to the cluster have the behaviour 3
%
%% Description
%This function creates the new total plot of the cluster, assuming that all
%the consumers that belong to the cluster have the behaviour 3. According to 
%this behaviour, consumers shift their load from the peak area to that area 
%where they have the lowest price.

unit=length(total_plot);
new_plot=zeros(1,unit);

%Find the number of elements of the total_plot that correspond to a peak
%arrea
peak_period=0;
for j=1:length(limits2)
    peak_period=peak_period+limits2(j)-limits1(j)+1;
end 

%Find the new values of the peak areas and compute the total reduction at the areas of
%peak
total_reduction=0;
for j=1:length(limits2)  
    for k=1:limits2(j)-limits1(j)+1
        new_peak=(1 - a * c * (bill(limits1(j)+k-1) - old_price)/old_price)*total_plot(limits1(j)+k-1);
        new_plot(1,limits1(j)+k-1)=new_peak;
        total_reduction=total_reduction+total_plot(limits1(j)+k-1)-new_peak;
    end
    
end

%Find the number of elements of the total_plot that correspond to a valley
%arrea
valley_period=0;
for j=1:length(limits1_valley)      
   valley_period=valley_period+limits2_valley(j)-limits1_valley(j)+1;
end

%Allocate the load from the total_reduction to the valley areas
for j=1:length(limits1_valley)
  new_plot(1,limits1_valley(j):limits2_valley(j))=total_plot(1,limits1_valley(j):limits2_valley(j))+total_reduction/valley_period;
end

%In all the other areas the values of load remain the same
for i=1:unit
    if new_plot(i)==0
       new_plot(i)= total_plot(i);
    end
end
    

end

