function simplices = buildSimplices(seqC,tStep)
% this function builds simplices from the array of facets
% returns a cell array, where simplices{d+1} contains d-simplices
% 
% written 4/10/24
%
% edit 11/10/24 by JJ to include variable tStep and build simplices
% directly from seqC instead of facets

% n_dim = maximal dimension of simplices - 1
arguments
    seqC,
    tStep = []
end
if ~isempty(tStep)
    seqC = seqC(tStep(1):tStep(2),:);
end

seqC = unique(seqC,'rows','sorted');
simplex_dim = sum(seqC,2); % sum by row
n_dim = max(simplex_dim);
% display(n_dim);
% remove chambers that never got hit
chamber_activity = sum(seqC,1); % sum by column
Idx_not_active = chamber_activity==0;
seqC(:,Idx_not_active) = [];

% number of vertices
[n_simplices,n_vertices] = size(seqC);
simplices{1} = (1:n_vertices)'; 

if n_dim > 1
    for i = 2:n_dim
        % add in (i-1)-simplices
        simplices_i = [];
        for j = 1:n_simplices
            face_i = find(seqC(j,:)==1);
            if simplex_dim(j) > i % have lower dimension simplices
                simplices_i = [simplices_i; nchoosek(face_i,i)]; % (i-1)-simplices from active chambers in facets(j,:)
            elseif simplex_dim(j) == i
                % face_i = find(seqC(j,:) == 1);
                simplices_i = [simplices_i; face_i]; % facets(j,:) contains a (i-1)-simplex
            end
        end
        simplices{i} = unique(simplices_i,'rows');
    end
end
end