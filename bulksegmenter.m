outputFolder='F:\Study\MS(CS)\All_datasets\skin\GT_Images\';
rootFolder = fullfile(outputFolder, 'ISBI2016_ISIC_Part1_Training_Data');

allfoldernames= struct2table(dir(rootFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;
imds1 = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');

outputFolder2='F:\Study\MS(CS)\All_datasets\skin\GT_Images\';
rootFolder2 = fullfile(outputFolder2, 'ISBI2016_ISIC_Part1_Training_GroundTruth');
allfoldernames2= struct2table(dir(rootFolder2));
for (i=3:height(allfoldernames2))
    new2(i-2)=allfoldernames2.name(i);
end
clear i
categories2=new2;
imds2 = imageDatastore(fullfile(rootFolder2, categories2), 'LabelSource', 'foldernames');

clear i cc rr chan r c im b bb aa a
[r c]=size(imds1.Files);
[r2 c2]=size(imds2.Files);
if(r==r2)
        for i=1:r
            a(i,1)=imds1.Files(i,1);
            aa=cell2mat(a(i,1));
           
            img1=imread(aa);
            img2=imresize(img1, [256 256]);
            % Pre Processing
            img3 = imadjust(img2,[.2 .3 0; .6 .7 1],[]);
            m = zeros(size(img2,1),size(img2,2));          %-- create initial mask
            m(100:end-100,100:end-100) = 1;
            seg = region_seg(img2, m, 700); %-- Run segmentation,subplot(221),imshow(img2),title('Input Image');
            finalImg = repmat(seg,[1 1 3]) .* im2double(img2);
% % % % % % % % % % % %    
b(i,1)=imds2.Files(i,1); 
 bb=cell2mat(b(i,1));
filename1=new{1,i};
filename=new2{1,i};
name = split(filename1,'.')';
name=string(name(1,1));
name1 = split(filename,'.')';
name1 = split(filename,'_')';
name1 =join(string([name1(1,1),'_',name1(1,2)]));
name1 = regexprep(name1, '\s+', '');
if (name==name1)
%  
gtruth=imread(bb);
gtruth=im2bw(gtruth);
gtruth=imresize(gtruth, [256 256]);

[x, y]=size(gtruth);
 gtruth=imresize(gtruth, [x  y]);
segmented=seg;
segVec = segmented(:);        % Algorithm segmented image
gtruthVec = gtruth(:);  % Ground truth
[rows, cols] = size(gtruthVec);
count = 0;
                for i= 1:rows
                    if (segVec(i) == 1 && gtruthVec(i) == 1)
                        count = count +1;
                    else
                        continue; 
                    end
                end
segCount = sum(sum(segmented));
gtruthCount = sum(sum(gtruth));
finalval = count/(segCount + gtruthCount - count);
finalval=finalval*100

%% Writing
[bpath,bname,bext] = fileparts([rootFolder,filename1]);
pathname=string(rootFolder2);

myFolders = split(bname,'_');
myFolders=myFolders(end,1);
d{1,1}=myFolders;
d{1,2}="  -   ";
d{1,3}=finalval;
file1=join([string(d),'\n']);
% % % % % % % % % % % % % % % 


if(finalval>=60)
cd F:\Study\MS(CS)\All_datasets\skin\GT_Images\segmented\new
fid = fopen('links.txt','a');
fprintf(fid, file1);
fclose(fid);
imwrite(img2,['1_',filename],'jpg');
imwrite(img3,['2_',filename],'jpg');
imwrite(seg,['3_',filename],'jpg');
imwrite(finalImg,['4_',filename],'jpg');
    [B,L] = bwboundaries(seg,'noholes');
    [B1,L1] = bwboundaries(gtruth,'noholes');
    imshow(img2);
    hold on
    for k = 1:length(B)
       boundary = B{k};
       plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    end
hold on
for k = 1:length(B1)
   boundary = B1{k};
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end
fff=['5_',filename];
saveas(gcf,fff)
else
   disp([filename,' --- ',filename1]);
   cd F:\Study\MS(CS)\All_datasets\skin\GT_Images\segmented\new
    fid = fopen('nearest.txt','a');
    fprintf(fid, file1);
    fclose(fid);
    disp('Segmentation Results are less than threshold which is 82')
end
else
    msg=join(["Matching Error-- ",...
            name ,'is GT Image and ',name,'is Input Image and ']);
        disp(msg)
end
        end
end
task();

