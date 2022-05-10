function features1= geometric(a)

%% Noise removal
BW = im2bw(a,0.8);
thinnedimg=1-BW;
thinnedimg=bwmorph(thinnedimg,'thin');
thinnedimg=imclose(thinnedimg,strel('line',5,45));
%  figure, imshow(thinnedimg), title('Binarized Image');

% % Skeletonization

 skltn = bwmorph( thinnedimg,'skel',Inf);
%  figure, imshow(skltn), title ('Thinned Image');


L = bwlabel(skltn);
% stats = regionprops(L,'FilledArea');
% FilledArea=sumpix(stats);
%  if isnan(FilledArea)
%     FilledArea=0;
% end
% features1{fa,2}=FilledArea;

stats = regionprops(skltn,'Area','Centroid','ConvexArea','Eccentricity','EulerNumber',...
'Extent', 'Extrema','FilledArea','FilledImage','MajorAxisLength' ,...
'MinorAxisLength','Orientation','Perimeter','PixelList',	'Solidity');
% % % % % % % % % % % % % % % %         Area
Area= stats.Area;
if isnan(Area)
    Area=0;
end
features1(1,1)=Area;
% % % % % % % % % % %                   Centroid
Centroid= stats.Centroid;
if isnan(Centroid)
    Centroid=0;
end
features1(1,2)=Centroid(1,1);
features1(1,3)=Centroid(1,2);
% % % % % % % % % % % % % % %           ConvexArea
ConvexArea= stats.ConvexArea;
if isnan(ConvexArea)
    ConvexArea=0;
end
features1(1,4)=ConvexArea;
% % % % % % % %                         Eccentricity
Eccentricity= stats.Eccentricity;
if isnan(Eccentricity)
    Eccentricity=0;
end
features1(1,5)=Eccentricity;
% % % % % % % % % % % %                 EulerNumber    
EulerNumber= stats.EulerNumber;
if isnan(EulerNumber)
    EulerNumber=0;
end
features1(1,6)=EulerNumber;
% % % % % % % % % % % % % % % % %       Extent
Extent= stats.Extent;
if isnan(Extent)
    Extent=0;
end
features1(1,7)=Extent;
% % % % % % % % % % %                   Extrema
Extrema= stats.Extrema;
if isnan(Extrema)
    Extrema=0;
end
features1(1,8)=Extrema(1,1);
features1(1,9)=Extrema(1,2);
features1(1,10)=Extrema(2,1);
features1(1,11)=Extrema(2,2);
features1(1,12)=Extrema(3,1);
features1(1,13)=Extrema(3,2);
features1(1,14)=Extrema(4,1);
features1(1,15)=Extrema(4,2);
features1(1,16)=Extrema(5,1);
features1(1,17)=Extrema(5,2);
features1(1,18)=Extrema(6,1);
features1(1,19)=Extrema(6,2);
features1(1,20)=Extrema(7,1);
features1(1,21)=Extrema(7,2);
features1(1,22)=Extrema(8,1);
features1(1,23)=Extrema(8,2);
% % % % % % % % % % % % % % %                   FilledArea
FilledArea= stats.FilledArea;
if isnan(FilledArea)
    FilledArea=0;
end
features1(1,24)=FilledArea;
% % % % % % % % % % % % % % %                    Perimeter
Perimeter= stats.Perimeter;
if isnan(Perimeter)
    Perimeter=0;
end
features1(1,25)=Perimeter;
% % % % % % % % % % % % % % % % % % %           MajorAxisLength
MajorAxis= stats.MajorAxisLength;
if isnan(MajorAxis)
    MajorAxis=0;
end
features1(1,26)=MajorAxis;
% % % % % % % % % % % % % % % % % %             MinorAxisLength
MinorAxis= stats.MinorAxisLength;
if isnan(MinorAxis)
    MinorAxis=0;
end
features1(1,27)=MinorAxis;
% % % % % % % % % % % % % % % % % % % %         Orientation
orien= stats.Orientation;
if isnan(orien)
    orien=0;
end
features1(1,28)=orien;
% % % % % % % % % % % % % % % % % %             Solidity
Solidity= stats.Solidity;
if isnan(Solidity)
    Solidity=0;
end
features1(1,(size(features1,2)+1))=Solidity;
end