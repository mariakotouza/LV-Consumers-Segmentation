function [newdata,dates,day_id_new,average_plot,average_plot_not_norm]= preprocess(data,dates,start_day)
%% Input arguments
%data->contains the initial data set with the measurements been taken 
%       from the smart meters
%dates->contains the dates of the measurements included in the data set
%start_day->the id of the day from which the measurements began.
%       We assume that: day_id=1->day=Monday,..,day_id=7->day=Sunday
%
%% Output arguments
%newdata->the data set that is created after the preprocessing. It has the
%       same formation as the input array-data.
%dates->contains the dates of the measurements included in the
%       array-newdata. We need this new array because some of the days
%       included into array-data may have been removed from the new
%       array-newdata, because of many wrong measurements.
%day_id_new->vector 1xNumber_of_days that contains the ids of the days that correspond to the 
%       new vector dates. We assume that:
%       day_id=1->day=Monday,..,day_id=7->day=Sunday
%average_plot->MxN array, where M=number of consumers 
%                                  and N=number of measurements
%       Contains the average normalized plots of the consumers of the dataset
%average_plot_not_norm->MxN array, where M=number of consumers 
%                                  and N=number of measurements
%       Contains the average not normalized plots of the consumers of the dataset   

%% Find out how many measurements we have per day and save this number in the variable 'unit'
%The formation of Dataset2 is an array

if size(data,2)>1
    unit=size(data,2);
    data_per_day=data;
    temp=[];
    for i=1:size(data,1)
        temp=[temp,data(i,:)];
    end
    clear data
    data=temp';
%The formation of Dataset1 is a vector. Contains 1440 measurements per day    
else
    data_per_day=0;
    unit=1440;
end

newdata=data;
newdata2=data;

%% Negative values
negative_index=find(data<0);
for i=1:length(negative_index)
    data(negative_index(i))=-data(negative_index(i));
end

%% Delete the days for which we have no measurements
num_of_days=floor(length(data)/unit);
day=zeros(num_of_days,unit);

delete_day=0;
j=0;
%% Repeat for each day of the data set
for i=1:num_of_days
    day(i,:)=data(1+(i-1)*unit:unit*i);

    %% The dates that are written in Dataset1 and Dataset2 have different formation
    %If the input data set is the Dataset1
    if unit==1440
        %Separate the dates into years,months and days
        dates_day(i,:)=dates(1+(i-1)*unit:unit*i);
        year=floor(dates_day(i,1)/10^8);
        month=floor((dates_day(i,1)-year*10^8)/10^6);
        day_num(i)=floor((dates_day(i,1)-year*10^8-month*10^6)/10^4);
    %If the input data set is the Dataset2       
    elseif unit==24
        %Separate the dates into years,months and days
        dates_day(i,:)=dates(i);
        year=floor(dates_day(i)/10^4);
        month=floor((dates_day(i)-year*10^4)/10^2);
        day_num(i)=floor(dates_day(i)-year*10^4-month*10^2);        
    end
    
    %% Find the id of the current day
    if i==1       
        day_id(i)=start_day;
    elseif day_num(i)-day_num(i-1)==1 || abs(day_num(i)-day_num(i-1))==30 || abs(day_num(i)-day_num(i-1))==29 || abs(day_num(i)-day_num(i-1))==28 || abs(day_num(i)-day_num(i-1))==27
        day_id(i)=mod(day_id(i-1)+1,7);
        if day_id(i)==0
            day_id(i)=7;
        end   
    else
        k=1;
    end
    
    %% Find out if the current day has only one load value
    %If yes, save i into the vector-delete_day
    same_values=find(day(i,:)==day(i,1));
    if length(same_values)==unit
        j=j+1;
        delete_day(j)=i;
    end
    
end

%% Remove the days that are contained into the vector-delete_day from newdata, 
%dates and day_id_new
day_id_new=day_id;
j=0;
if delete_day(1)>0
    clear day_id_new
    for i=1:num_of_days
        if isempty(find(delete_day==i))
            j=j+1;
            day_new(j,:)=day(i,:);
            dates_day_new(j,:)=dates_day(i,:);
            day_id_new(j)=day_id(i);
            if i<14
            %figure
            %plot(day_new(j,:));
            end
        end
    end
    data_new=day_new(1,:);
    dates_new=dates_day_new(1,:);
    
    for k=2:size(day_new,1)
        data_new=[data_new,day_new(k,:)];
        dates_new=[dates_new,dates_day_new(k,:)];
    end
    data=0;
    data=data_new;
    dates=0;
    dates=dates_new;
    day=0;
    day=day_new;
    newdata=data;
    num_of_days=size(day,1);
end

%% Find the average load profile of the data before the preprocessing
meanday=mean(day);
%figure
%plot(meanday);
%title('average plot before preprocessing');


%% Find which days are not close to the min,max,average
for i=1:num_of_days
    min_value(i)=min(day(i,:));
    max_value(i)=max(day(i,:));
    average_value(i)=mean(day(i,:));
end

wrong_index_min=find(abs(min_value-mean(min_value))>mean(min_value));
wrong_index_max=find(abs(max_value-mean(max_value))>mean(max_value)); 
wrong_index_av=find(abs(average_value-mean(average_value))>mean(average_value)*0.7);


%Upward or downward shift for the wrong_index_min measurements
for i=1:length(wrong_index_min)
        k=0;
        %Find the next correct meassurement after the wrong_index_min(i)
        for j=wrong_index_min(i)+1:num_of_days
            if isempty(find(wrong_index_min==j))
                k=j;
                break;
            end
        end
        if k>0
            diff=min_value(wrong_index_min(i))-min_value(k);
            %Upward or downward shift
            newdata((wrong_index_min(i)-1)*unit+1:(wrong_index_min(i)-1)*unit+unit)=newdata((wrong_index_min(i)-1)*unit+1:(wrong_index_min(i)-1)*unit+unit)-diff;
        else
            %Find from where the wrong_index_min(i) begins and save the index into
            %variable-k.The value min_value(k) is right
            for j=wrong_index_min(i)-1:-1:1
                if isempty(find(wrong_index_min==j))
                    k=j;
                    break;
                end
            end
            diff=min_value(wrong_index_min(i))-min_value(k);
            %Upward or downward shift
            newdata((wrong_index_min(i)-1)*unit+1:(wrong_index_min(i)-1)*unit+unit)=newdata((wrong_index_min(i)-1)*unit+1:(wrong_index_min(i)-1)*unit+unit)-diff;
        end
end

%Correct the wrong_index_max measurements replacing them with the correct
%measurements that occur after them or before them.
for i=1:length(wrong_index_max)
    %If the wrong_index_max(i) measurements is contained into wrong_index_av
    if length(find(wrong_index_av==wrong_index_max(i)))>0
        k=0;
        %Find the next correct measurement after the wrong_index_max(i)
        for j=wrong_index_max(i)+1:num_of_days
            if isempty(find(wrong_index_max==j))
                k=j;
                break;
            end
        end
        if k>0
            newdata((wrong_index_max(i)-1)*unit+1:(wrong_index_max(i)-1)*unit+unit)=newdata((k-1)*unit+1:k*unit);
        %If there is no correct measurement after the wrong_index_max(i) 
        %find the previous correct measurement before wrong_index_max(i).
        else
            for j=wrong_index_max(i)-1:-1:1
                if isempty(find(wrong_index_max==j))
                    k=j;
                    break;
                end
            end
            newdata((wrong_index_max(i)-1)*unit+1:(wrong_index_max(i)-1)*unit+unit)=newdata((k-1)*unit+1:k*unit);
        end
    end
end


%% Continues same values
F=0;
c=0;
index=0; %index where the same values end
j=0;     %current number of times that the measurements are wrong
for i=2:length(newdata)
   if abs(newdata(i)-newdata(i-1))==0 
       c=c+1;
       F=1;
   elseif F==1
       F=0;
       if c>50
          j=j+1;    
          index(j)=i-1; 
          values(j)=c;
       end
       c=0;
   end
end


%% Correct the wrong measurements (Continues same values)
if index(1)>0 
    for i=1:length(index)
        %average between the values of the same hours of the previous and
        %the next day of the wrong measurements
        if index(i)-values(i)-unit+1>0 && index(i)+unit<length(data) && ((i<length(index) && index(i)+unit<index(i+1)-values(i+1)+1) || i==length(index))
            newdata(index(i)-values(i)+1:index(i))=(newdata(index(i)-values(i)-unit+1:index(i)-unit)+newdata(index(i)-values(i)+unit+1:index(i)+unit))./2;
        %values of the same hours of the previous day
        elseif index(i)-values(i)-unit+1>0
            newdata(index(i)-values(i)+1:index(i))=newdata(index(i)-values(i)-unit+1:index(i)-unit);  
        else
            %take the values of the same hours of the next day that has 
            %correct measurements
            k=0;
            for j=index(i)+1:num_of_days
                if isempty(find(index(i)==j))
                    k=j;
                    break;
                end
            end
            if k>0
                newdata(index(i)-values(i)+1:index(i))=newdata(index(i)-values(i)+(k-1)*unit+1:index(i)+(k-1)*unit);
            end
        end
    end
end

%% Find big peaks
big_values=find(newdata>100000);
for i=1:length(big_values)
    if big_values(i)-unit>0 && big_values(i)+unit<length(data)
        temp=[newdata(big_values(i)-unit:big_values(i)-1);newdata(big_values(i)+1:big_values(i)+unit)];
        if abs(mean(temp)-newdata(big_values(i)))>100000
            %remove the measurements with index equal to big_values(i)
            newdata(big_values(i))=(newdata(big_values(i)-1)+newdata(big_values(i)+1))/2;
        end
    elseif big_values(i)-unit<0 && big_values(i)+unit<length(data)
        temp=[newdata(1:big_values(i)-1);newdata(big_values(i)+1:big_values(i)+unit)];
        if abs(mean(temp)-newdata(big_values(i)))>100000
            %remove the measurements with index equal to big_values(i)
            newdata(big_values(i))=(newdata(big_values(i)-1)+newdata(big_values(i)+1))/2;
        end  
    elseif big_values(i)+unit>length(data)
        temp=[newdata(big_values(i)-unit:big_values(i)-1);newdata(big_values(i)+1:length(newdata))];
        if abs(mean(temp)-newdata(big_values(i)))>100000
            %remove the measurements with index equal to big_values(i)
            newdata(big_values(i))=(newdata(big_values(i)-1)+newdata(big_values(i)+1))/2;
        end        
    end
end

%% Find the new average load profile 
for i=1:num_of_days
    day(i,:)=newdata(1+(i-1)*unit:unit*i);
end
average_plot_not_norm=mean(day);

%normalization
average_plot=average_plot_not_norm/max(average_plot_not_norm);


end

