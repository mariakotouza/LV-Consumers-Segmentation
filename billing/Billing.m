function [cost_reduction,PR,CR_PER,PR_PER,bill,total_plot,new_plot]=Billing(average_plot_not_norm,idx,ci,peak_factor,behavior_factor,a,c)
%% Input arguments:  
%average_plot_not_norm->MxN array, where M=number of
%       consumers and N=number of measurements
%       Contains the average not normalized plot of each consumer of the dataset     
%idx->vector Mx1 that shows in which cluster each consumer belongs to
%ci->CxN array, where C=number of clusters. Contains the centres of each
%       cluster
%peak_factor->The factor with which we multiple basic price to find the
%       new price at the peak area
%behavior_factor->1x3 vector that contains the rates of each one of the
%       three consumer behaviours
%
%% Output arguments:
%cost_reduction->Cx1 vector that contains the cost reduction after the
%       application of the new tariff
%PR->Cx1 vector that contains the peak reduction after the application of 
%       the new tariff
%CR_PER->Cx1 vector that contains the percentage of cost reduction after 
%       the application of the new tariff
%PR-PER->Cx1 vector that contains the percentage of peak reduction after 
%       the application of the new tariff
%bill->CxN array that contains the new tariffs for each consumer
%
%% Description:
%This function finds the peak regions and the valley regions of the sum of 
%the average plots of each cluster and computes the new tariff for each one  
%of them. Then, it finds the overall consumer behavior of each cluster, assuming  
%that the consumers have 3 possible behaviors with the rates shown in the vector 
%behavior_factor. In the end,it computes the peak reduction and the cost 
%reduction that we have with the new tariffs.

%Initialization
basic_price=0.5;
peak_price=peak_factor*basic_price;
unit=size(average_plot_not_norm,2);
bill=zeros(size(ci,1),unit);

%Repeat for each cluster
for i=1:size(ci,1)
    
    %Find the elements of the cluster-i
    clusteri=find(idx==i);
    %Add all the average plots that belong to cluster-i and create total_plot
    total_plot(i,:)=zeros(1,size(average_plot_not_norm,2));
    for j=1:length(clusteri)
        total_plot(i,:)=total_plot(i,:)+average_plot_not_norm(clusteri(j),:);
    end
    
    %% Peak Detection
    bill(i,:)=zeros(1,unit);
    clear peak_list
    clear peak_list_index
    clear limits1
    clear limits2
    %% Peak Detection
    [peak_list,peak_list_index] = peak_detection(total_plot(i,:),0.985);
    for j=1:length(peak_list_index)
        [limits1(j),limits2(j)]=find_region_of_peak(total_plot(i,:),peak_list_index(j),0.985);
    end
    peak_period=0;
    for j=1:length(peak_list_index)
        bill(i,limits1(j):limits2(j))=peak_price;
        peak_period=peak_period+limits2(j)-limits1(j)+1;
    end
       
    %% Valley Detection
    [valley_list,valley_list_index] = valley_detection(total_plot(i,:));
    for j=1:length(valley_list_index)
        [limits1_valley(j),limits2_valley(j)]=find_region_of_valley(total_plot(i,:),valley_list_index(j));
    end
    valley_period=0;
    for j=1:length(valley_list_index)
        valley_period=valley_period+limits2_valley(j)-limits1_valley(j)+1;
    end
    
    %% Create new bill    
    not_peak_price=(basic_price*24-peak_price*peak_period/(unit/24))/(unit-peak_period-valley_period+0.85*valley_period);
   
    %Valley price
    for j=1:length(valley_list_index)
        bill(i,limits1_valley(j):limits2_valley(j))=not_peak_price*0.85;
    end
    for j=1:unit
        if bill(i,j)==0
            bill(i,j)=not_peak_price;
        end
    end
    
    
    %Find the new plot and the new cost, assuming that all the consumers of 
    %cluster-i have the behavior 1
    new_plot1(i,:) = uniform_reduction(total_plot(i,:),bill(i,:),basic_price,limits1,limits2,a,c);
    
    %Find the new plot and the new cost, assuming that all the consumers of 
    %cluster-i have the behavior 2
    new_plot2(i,:) = before_and_after_reduction(total_plot(i,:),bill(i,:),basic_price,limits1,limits2,a,c);
    
    %Find the new plot and the new cost, assuming that all the consumers of 
    %cluster-i have the behavior 3    
    new_plot3(i,:) = cheaper_reduction(total_plot(i,:),bill(i,:),basic_price,limits1,limits2,limits1_valley,limits2_valley,a,c);
    
    price_old(i,:)=sum(total_plot(i,:)*0.5*24/unit);
    
    %Find the final total plot using the given rates of the 3 behaviors
    new_plot(i,:)=new_plot1(i,:)*behavior_factor(1)+new_plot2(i,:)*behavior_factor(2)+new_plot3(i,:)*behavior_factor(3);
    
    %% Overall Cost Reduction
    cost(i,:)=sum(new_plot(i,:).*bill(i,:)*24/unit);
    cost_reduction(i,:)=price_old(i,:)-cost(i,:);
    
    %Percantage of cost reduction
    CR_PER(i,:)=cost_reduction(i,:)/price_old(i,:);
    
    %% Peak Reduction: Reduction of the load at the peak regions
    PR1=0;
    PR2=0;
    PR3=0;
    Peak(i,1)=0;
    PR(i,:)=0;
    
    for j=1:length(peak_list_index)
        Ebaseline=sum(total_plot(i,limits1(j):limits2(j)));       
        Eresponse=sum(new_plot(i,limits1(j):limits2(j)));     
        PR(i,:)=PR(i,:)+Ebaseline-Eresponse;
        Peak(i,1)=Peak(i,1)+Ebaseline;
    end
    
    %Percantage of peak reduction
    PR_PER(i,:)=PR(i,:)/Peak(i,1);
    
    %% Clear variables
    clear clusteri;
    clear limits1;
    clear limits2;
    clear limits1_valley;
    clear limits2_valley;
end

end

