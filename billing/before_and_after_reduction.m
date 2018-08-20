function [new_plot] = before_and_after_reduction(total_plot,bill,old_price,limits1,limits2,a,c)
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
%
%% Output arguments
%new_plot->the new average plot of the cluster that is created when all the
%       consumers that belong to the cluster have the behaviour 2
%
%% Description
%This function creates the new total plot of the cluster, assuming that all
%the consumers that belong to the cluster have the behaviour 2. According to 
%this behaviour, consumers shift their load from the peak area to the area
%before and after the peak.


unit=length(total_plot);
new_plot=zeros(1,unit);

%Find the number of elements of the total_plot that correspond to a peak
%area
peak_period=0;
for j=1:length(limits2)
    peak_period=peak_period+limits2(j)-limits1(j)+1;
end 

%Find the new values of the peak areas and compute the total reduction at the areas of
%peak
for j=1:length(limits2)
    total_reduction(j)=0;
    for k=1:limits2(j)-limits1(j)+1
        new_peak=(1 - a * c * (bill(limits1(j)+k-1) - old_price)/old_price)*total_plot(limits1(j)+k-1);
        new_plot(1,limits1(j)+k-1)=new_peak;
        total_reduction(j)=total_reduction(j)+total_plot(limits1(j)+k-1)-new_peak;
    end
    
end

%Shift the load before and after the peak area. The area before and the
%area after the peak area correspond to 6 elements.
for j=1:length(limits2)
    %Allocate the load to the area at the left side of the peak area
    if limits1(j)-6>0
        start=limits1(j)-6;
    else
        start=1;
    end
    for i=start:limits1(j)-1
        if new_plot(i)~=0
            new_plot(i)= new_plot(i)+total_reduction(j)/(2*(limits1(j)-start));
        else
            new_plot(i)= total_plot(i)+total_reduction(j)/(2*(limits1(j)-start));
        end
    end
    
    %Allocate the load to the area at the right side of the peak area
    if limits2(j)+6<unit
        finish=limits2(j)+6;
    else
        finish=unit;
    end    
    for i=limits2(j)+1:finish
        if new_plot(i)~=0
            new_plot(i)= new_plot(i)+total_reduction(j)/(2*(finish-limits2(j)));
        else
            new_plot(i)= total_plot(i)+total_reduction(j)/(2*(finish-limits2(j)));
        end
    end    
end

%In all the other areas the values of load remain the same
for i=1:unit
    if new_plot(i)==0
       new_plot(i)= total_plot(i);
    end
end
    

end

