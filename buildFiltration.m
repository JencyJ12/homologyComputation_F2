function [filtration, simplex_time]=buildFiltration(seqC,time,tStep, sim, incVert)
% this function builds a filtration of simplicial complexes based on
% time spent in each chamber
%
% input, seqC, an array whose rows corresponds to the chambers activity
%               is in, seqC from find_linchambers
%        time, t_idx from find_linchambers
%        sim, a boolean indicating where True indicates the filtration will
%        go from larger value to lower value of simplices
%        incVert, a boolean indicating whether to include vertices i based on
%        time spent in chambers, otherwise, assume all vertices are added
%        in first
%        
% output, filtration, an array in order of added chambers without adding
%         0-simplices 
%         simplex_time, time spent in chambers in corresponding order to
%         filtration
%         
%
% Written 11/10/24 by JJ
%
% edit 18/10/24 to include the option to also compute time spent in
% vertices
if ~isempty(tStep)
    chamber = seqC(tStep(1):tStep(2),:);
    time = time(tStep(1):tStep(2));
end


u_chamber = unique(chamber,"rows","sorted");
n_chambers = size(u_chamber,1);
time_chamber = [];

% record time spent in each chamber in u_chamber
for i = 1:n_chambers
    target_chamber = u_chamber(i,:);
    time_idx = all(chamber==target_chamber,2);
    time_spent = sum(time(time_idx));
    time_chamber = [time_chamber;time_spent];
end
% display(time_chamber);
% compute time spent for each simplex
simplices = buildSimplices(u_chamber);  % obtain all faces
% display(simplices);
n_dim = length(simplices{1}); 
filtration = [];
% display(filtration);
simplex_time = [];
if incVert
   for i = 1:length(simplices)
       i_simplex = simplices{i};
            
       % display(i_simplex)
       for j = 1:size(i_simplex,1)
           curr_simp = zeros(1,n_dim);
           % display(curr_simp);
           curr_simp(i_simplex(j,:)) = 1;
           % display(curr_simp);
           filtration = [filtration; curr_simp];
           row_sum = sum(u_chamber(:,i_simplex(j,:)),2); 
           i_simplex_idx = row_sum==i; % if row_sum == i for the j-th row, then the (i-1)-simplex is contained in u_chamber(j)
           simplex_time = [simplex_time; sum(time_chamber(i_simplex_idx))];
      end
   end
else
    if length(simplices)>1
        for i = 2:length(simplices)
            i_simplex = simplices{i};
            
            % display(i_simplex)
            for j = 1:size(i_simplex,1)
                curr_simp = zeros(1,n_dim);
                % display(curr_simp);
                curr_simp(i_simplex(j,:)) = 1;
                % display(curr_simp);
                filtration = [filtration; curr_simp];
                row_sum = sum(u_chamber(:,i_simplex(j,:)),2); 
                i_simplex_idx = row_sum==i; % if row_sum == i for the j-th row, then the (i-1)-simplex is contained in u_chamber(j)
                simplex_time = [simplex_time; sum(time_chamber(i_simplex_idx))];
            end
        end
    end
end

% display(simplex_time)
if sim
    [simplex_time,I] = sort(simplex_time,'descend');
else
    [simplex_time,I] = sort(simplex_time,'ascend');
end
% display(I)
% display(simplex_time)
% display(filtration);
% build filtration
filtration = filtration(I,:);
% simp_0 = nkCycle(n_dim,1);
% filtration = [simp_0;filtration];
% display(filtration);
end