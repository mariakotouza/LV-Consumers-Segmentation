function attributes = create_attributes(data,dates,day_id,unit)
%% Input arguments:  
%data->vector that contains the consumption messurements for a consumer  
%dates->vector that contains the date of the messurements
%day_id->vector that contains the ids of the days that correspond to the 
%       vector dates. We assume that:
%       day_id=1->day=Monday,..,day_id=7->day=Sunday
%unit-> the number of massurements that we have for each day
%       
%% Output arguments: 
%attributes->vector of 7 attributes that characterises each consumer.
%Where:
%attribute 1-4: The relative average power in each time period over the entire year
%attribute 5: Mean relative standard deviation over the entire year
%attribute 6: Seasonal score
%attribute 7: Weekend vs Weekday score
%
%We assume that each day can be saperated into 4 periods:
%period 1: 00:00-06:00
%period 2: 6:00-12:00
%period 3: 12:00-18:00
%period 4: 18:00-24:00
%                               
%% Discription
%This function creates a vector of 7 attributes for a consumer that
%characterises him.



%% Initialization
num_of_days=floor(length(data)/unit);
day=zeros(num_of_days,unit);

delete_day=0;
period_s1=[];   %period 1 for summer season
period_s2=[];   %period 2 for summer season
period_s3=[];   %period 3 for summer season
period_s4=[];   %period 4 for summer season

period_w1=[];   %period 1 for winter season
period_w2=[];   %period 2 for winter season
period_w3=[];   %period 3 for winter season
period_w4=[];   %period 4 for winter season

%indexes
j=0;
w=0;
s=0;
we=0;
wd=0;

%% Repeat for each day 
for i=1:num_of_days
    
    day(i,:)=data(1+(i-1)*unit:unit*i);
    
    %The dates that are written in Dataset1 and Dataset2 have different formation
    %If the input data set is the Dataset1
    if unit==1440
        %Seperate the dates into years,months and days
        dates_day(i,:)=dates(1+(i-1)*unit:unit*i);
        year=floor(dates_day(i,1)/10^8);
        month=floor((dates_day(i,1)-year*10^8)/10^6);
        day_num(i)=floor((dates_day(i,1)-year*10^8-month*10^6)/10^4);
    %If the input data set is the Dataset2    
    elseif unit==24
        %Seperate the dates into years,months and days
        dates_day(i,:)=dates(i);
        year=floor(dates_day(i)/10^4);
        month=floor((dates_day(i)-year*10^4)/10^2);
        day_num(i)=floor(dates_day(i)-year*10^4-month*10^2);        
    end

    %Find the Summer season
    if month==6 || month==7 || month==8
        s=s+1;
        period_s1(s,:)=day(i,1:unit/4);
        period_s2(s,:)=day(i,unit/4+1:unit/2);
        period_s3(s,:)=day(i,unit/2+1:3*unit/4);
        period_s4(s,:)=day(i,3*unit/4+1:unit);
    end
    
    %Find the Winter season
    if month==12 || month==1 || month==2
        w=w+1;
        period_w1(w,:)=day(i,1:unit/4);
        period_w2(w,:)=day(i,unit/4+1:unit/2);
        period_w3(w,:)=day(i,unit/2+1:3*unit/4);
        period_w4(w,:)=day(i,3*unit/4+1:unit);        
    end 
    
    %Weekday
    if day_id(i)<6
        wd=wd+1;
        period_wd1(wd,:)=day(i,1:unit/4);
        period_wd2(wd,:)=day(i,unit/4+1:unit/2);
        period_wd3(wd,:)=day(i,unit/2+1:3*unit/4);
        period_wd4(wd,:)=day(i,3*unit/4+1:unit);
    %Weekend
    else
        we=we+1;
        period_we1(we,:)=day(i,1:unit/4);
        period_we2(we,:)=day(i,unit/4+1:unit/2);
        period_we3(we,:)=day(i,unit/2+1:3*unit/4);
        period_we4(we,:)=day(i,3*unit/4+1:unit);
    end     
 
end

overall_mean=mean(mean(day));

%Mean of summer season for each period of the day
period_mean_s(1)=mean(mean(period_s1));
period_mean_s(2)=mean(mean(period_s2));
period_mean_s(3)=mean(mean(period_s3));
period_mean_s(4)=mean(mean(period_s4));

%Mean of winter season for each period of the day
period_mean_w(1)=mean(mean(period_w1));
period_mean_w(2)=mean(mean(period_w2));
period_mean_w(3)=mean(mean(period_w3));
period_mean_w(4)=mean(mean(period_w4));

%Mean of weekends for each period of the day
period_mean_we(1)=mean(mean(period_we1));
period_mean_we(2)=mean(mean(period_we2));
period_mean_we(3)=mean(mean(period_we3));
period_mean_we(4)=mean(mean(period_we4));

%Mean of weekdays for each period of the day
period_mean_wd(1)=mean(mean(period_wd1));
period_mean_wd(2)=mean(mean(period_wd2));
period_mean_wd(3)=mean(mean(period_wd3));
period_mean_wd(4)=mean(mean(period_wd4));


season=0;
sum_std=0;
we_vs_wd=0;
%Repeat for each of the 4 time periods
for i=1:4
    %Average value of each time period
    period_mean(i)=mean(mean(day(:,(i-1)*unit/4+1:i*unit/4)));
    %Standard deviation for each time period
    period_std(i)=std(mean(day(:,(i-1)*unit/4+1:i*unit/4)));
    
    %Compute the relative average power in each time period
    if overall_mean~=0
        attributes(i)=period_mean(i)/overall_mean;
    else
        attributes(i)=period_mean(i)/0.0001;
    end
    
    %Compute the seasonal score for each time period
    if length(period_mean_s)>0 && length(period_mean_s)>0
        if period_mean(i)~=0
            season=season+abs(period_mean_s(i)-period_mean_w(i))/period_mean(i);
        else
            season=season+abs(period_mean_s(i)-period_mean_w(i))/0.0001;
        end
    end
    
    if period_mean(i)~=0
        %Compute the Weekend vs Weekday score
        we_vs_wd=we_vs_wd+abs(period_mean_wd(i)-period_mean_we(i))/period_mean(i);
        %relative standard deviation
        sum_std=sum_std+period_std(i)/period_mean(i);
    else
        we_vs_wd=we_vs_wd+abs(period_mean_wd(i)-period_mean_we(i))/0.0001;
        %relative standard deviation
        sum_std=sum_std+period_std(i)/0.0001;
    end
end

%Average relative standard deviation
attributes(5)=sum_std/4;
%Seasonal score
attributes(6)=season;
%Weekend vs Weekday score
attributes(7)=we_vs_wd;

end

