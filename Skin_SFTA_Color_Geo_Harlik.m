clear all;
clc;
imagespath=imageSet('E:\Alishba\Database');
imagecount=1;
% s = size(imagespath,4);
for i=1 : size(imagespath,2)
    m=size(imagespath(i).ImageLocation,2);
    temp=imagespath(i).ImageLocation;
     for j=1 :  m
        v{imagecount,1}=temp{j};
        
            if(~isempty(strfind(temp{j},'BR')))
                v{imagecount,2}='E';
            elseif (~isempty(strfind(temp{j},'BlackMeasles')))
                v{imagecount,2}='M';
            elseif (~isempty(strfind(temp{j},'healthy')))
                v{imagecount,2}='O';
%             elseif (~isempty(strfind(temp{j},'puffin')))
%                 v{imagecount,2}='P';
%             elseif (~isempty(strfind(temp{j},'toucan')))
%                 v{imagecount,2}='T';
                else
                  v{imagecount,2}='W'; 
                end
            
            img=imread(v{imagecount,1});
            
            img=imresize(img,[96,128]);
% bn=graythresh(img);
% bn1=im2bw(img,bn);
             
             featureVector = extractHOGFeatures(img);

             m74dataset{imagecount}= img; 
%                 featureVector = etectSURFFeatures(img);
            
            feature{imagecount,1}=featureVector(1,:);

            imagecount=imagecount+1;
     end
end
%  perm = randperm(size(feature)) ;
% sel = perm(1:50) ;
Geo_Features = Untitled5(m74dataset);
Geo_Features=Geo_Features(:,3:8);
Geo_Features = cell2mat(Geo_Features);
for i=1:length(feature)
    
    ftemp=double(feature{i});
    
    FV(i,:)=ftemp;  
end

X=v(:,2);


%  [pc,score,latent,tsquare] = princomp(FV);
%     [pc,score,latent] = pca(FV);
%Only PCA
  [pc,score] = princomp(FV);
  red_dim_Hog = score(:,1:200);
 
%  [r3, c3]=size(Geo_Features);
% new_score_Geo=princomp(Geo_Features,c3);
% red_dim_Geo = new_score_Geo;
  %PCA Followed by Entropy
%   [r, c]=size(score);
%   new_score = Find_Entropy(score,c);
%   red_dim_Hog = new_score(:,1:30);
%   [r1, c1]=size(score1);
%   new_score1 = Find_Entropy(score1,c1);
%   red_dim_Sfta = new_score1(:,1:15);
%   [r2, c2]=size(score2);
%   new_score2 = Find_Entropy(score2,c2);
%   red_dim_Color = new_score2(:,1:48);


  
  
  red_dim = horzcat(red_dim_Hog,Geo_Features);
   red_dim(:,size(red_dim,2)+1)=cell2mat(X);
   
   
%   [r4, c4]=size(red_dim);
%   red_dim_All_Entropy = Find_Entropy(red_dim,c4);
%   red_dim_Tex_Color = horzcat(red_dim_Sfta,red_dim_Color);
%   red_dim(:,size(red_dim,2)+1)=cell2mat(X);
%   red_dim_Sfta(:,size(red_dim_Sfta,2)+1)=cell2mat(X);
%   red_dim_Harlik(:,size(red_dim_Harlik,2)+1)=cell2mat(X);
%   red_dim_Color(:,size(red_dim_Color,2)+1)=cell2mat(X);
%   red_dim_Tex_Color(:,size(red_dim_Tex_Color,2)+1)=cell2mat(X);
%   red_dim_All_Entropy(:,size(red_dim_All_Entropy,2)+1)=cell2mat(X);

  
  
