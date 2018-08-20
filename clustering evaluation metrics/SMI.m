function m = SMI(ci)
%% Input arguments
%ci->CxN array, where C=number of num_of_cl. 
%       Contains the centres of the num_of_cl that are created
%
%% Output arguments
%m->the Similarity Matrix Indicator of the clusters
%
%% Description
%This function computes the Similarity Matrix Indicator of the clusters

C=size(ci,1) ; %number of clusters
k=0;
for p=1:C
    for q=1:C
        if p>q
            k=k+1;
            elem(k)=1/(1-1/(log(d(ci(p,:),ci(q,:)))/log(2.71828)));
        end
    end
end

m=max(elem);

end

