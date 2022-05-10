clear all

tic
pathname='D:\madical\PH2\testing';
imagespath=imageSet(pathname,'recursive');
imagecount=1;
 allfoldernames= struct2table(dir(pathname));
        for (i=3:height(allfoldernames))
            new(i-2)=allfoldernames.name(i);
        end
for i=1 : size(imagespath,2)
    m=size(imagespath(i).ImageLocation,2);
    temp=imagespath(i).ImageLocation;
     for j=1 :  m
        v{imagecount,1}=temp{j};
        if(~isempty(strfind(temp{j},new(1,i))))
                v{imagecount,2}=new(1,i);    
        else
            v{imagecount,2}='None';
        end
            img=imread(v{imagecount,1}); 
            if(size(img, 3) == 3)
            imggray=double(rgb2gray(img));
            end
             covector=graycomatrix(imggray);
            img=imresize(img,[128,96]);
               colorfeat= colorfeatures(img);
               geofeat= geometric(img);
               haralickfeat = haralickTextureFeatures(covector);
               hogfeat = extractHOGFeatures(img);
               haralickfeat(isnan(haralickfeat))=0;
% % % % % % % % % % % % % % % % % 
             featurecolor{imagecount,1}=colorfeat(1,:);  
             featuregeo{imagecount,1}=geofeat(1,:);
             featureharalick{imagecount,1}=haralickfeat(1,:);
             featurehog{imagecount,1}=hogfeat(1,:);
        imagecount=imagecount+1;
     end
end
% %%
 maxSize = max(cellfun(@numel,featurecolor)); 
 minSize = min(cellfun(@numel,featurecolor)); 
 setsize=minSize+maxSize;
if mod(setsize, 2) == 0
 setsize=setsize;
else
 setsize=setsize+1;
end
setsize=(setsize)/2;
for i=1:length(featurecolor)
    pad=setsize-length(featurecolor{i});
    element = featurecolor{i};
    meanval=mean(element);
    if(size(element,2))<setsize
    featurecolornew(i,:)= padarray(featurecolor{i},[0 pad],3.7777,'post');
    else
        featurecolornew(i,1:setsize)= element(1,1:setsize);
    end
end
FV1=featurecolornew;

for i=1:length(featuregeo)
    ftemp1=double(featuregeo{i});
    FV2(i,:)=ftemp1;
end
for i=1:length(featureharalick)
    ftemp1=double(featureharalick{i});
    FV3(i,:)=ftemp1;
end
for i=1:length(featurehog)
    ftemp=double(featurehog{i});
    FV4(i,:)=ftemp;
end
%%
y=v(:,2);
%%  Entropy Based Selection
[r, c]=size(FV1);
new_score = Find_Entropy(FV1,c);
ent_FV1 = real(new_score(:,1:1000));
[r1, c1]=size(FV2);
new_score2 = Find_Entropy(FV2,c1);
ent_FV2 = real(new_score2(:,1:20));
[r2, c2]=size(FV3);
new_score3 = Find_Entropy(FV3,c2);
ent_FV3 = real(new_score3(:,1:16));
[r3, c3]=size(FV4);
new_score4 = Find_Entropy(FV4,c3);
ent_FV4 = real(new_score4(:,1:5000));
%% 
Fused=horzcat(FV1,FV2,FV3);
Fused_hog=horzcat(FV1,FV2,FV3,FV4);
Fused_Ent=horzcat(ent_FV1,ent_FV2,ent_FV3);
Fused_Hog_Ent=horzcat(ent_FV1,ent_FV2,ent_FV3,ent_FV4 );

%%
FinalFused=cell2table(horzcat(y,num2cell(Fused)));
FinalHogFused=cell2table(horzcat(y,num2cell(Fused_hog)));
FinalFused_Ent=cell2table(horzcat(y,num2cell(Fused_Ent)));
FinalFused_Hog_Ent=cell2table(horzcat(y,num2cell(Fused_Hog_Ent)));

time=toc

%%  clearing Variables
 clear featurecolornew covector element
 clear FV1 colorfeat ftemp1 img minSize v FV2 FV3 featurecolor geofeat imggray new featurecolornew i j pad ...
 Fused featuregeo imagecount pathname allfoldernames ftemp imagespath maxSize temp m featureharalick covector 