function dist = d(xi,ci)
%% Input arguments
%xi->vector of measurements
%ci->vector of measurements
%
%% Output arguments
%dist->the Euclidean distance between the given vectors
%
%% Description
%This function computes the Euclidean distance between the given vectors

dist=sqrt(sum((xi-ci).^2));

end

