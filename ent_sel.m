function [output]=ent_sel(mat,perc)
c=size(mat,2);
new_score = Find_Entropy(mat,c);
perc
perc=(size(new_score,2))*perc;
output = real(new_score(:,1:(perc)));
end