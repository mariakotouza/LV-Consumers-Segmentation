function [idx,ci] = som(data,num_of_cl,neigh,topo,dist)
%% Input arguments
%data->
%       MxN array, where M=number of consumers 
%                         and N=number of measurements 
%       Contains the average plots of the consumers of the dataset 
%OR
%       Mx7 array, where M=number of consumers 
%       Contains the attributes that characterise the consumers of the dataset 
%
%num_of_cl->number of clusters that we want to create
%neigh->Initial neighbourhood size
%topo->Layer topology function 
%dist->Neuron distance function
%% Description
%This function implements the Som clustering algorithm. 

if floor(num_of_cl/2)==num_of_cl/2
    a1=2;
    a2=num_of_cl/2;
elseif floor(num_of_cl/3)==num_of_cl/3
    a1=3;
    a2=num_of_cl/3;
else
    a1=1;
    a2=num_of_cl;
end
    
net = selforgmap([a1 a2], 100, neigh,topo, dist);

net = train(net,data');
nntraintool
y = net(data');
idx = vec2ind(y)';
ci = cell2mat(net.IW);

end