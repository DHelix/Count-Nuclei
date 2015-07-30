function y = CN(I,Izo1,outputFileName)

%Functions:
%   -count neclei
%   -label the index on top of each neclei


%filename = input('Enter name of file:  ', 's');
%[filename, pathname] = uigetfile('*.*', 'Select an image file');
%I=imread(filename);
imshow(I)
%[filename_zo1, pathname] = uigetfile('*.*', 'Select an image file');
%Izo1=imread(filename_zo1);
imshow(Izo1)

%adjust image contrast
background = imopen(I,strel('disk',50));
I2=I-background;
I3=imadjust(I2);

%general mask
level=graythresh(I3)*0.5;
bw = im2bw(I3,level);
%bw = imclose(bw,strel('disk', 10)); %use imclose may cause bad separation
bw = imerode(bw,strel('disk',10));
bw = bwareaopen(bw, 10);

%count nuclei
cc = bwconncomp(bw, 8);
y=cc.NumObjects;

%find the boundaries
[B]=bwboundaries(bw,'noholes');

%label
labeled = labelmatrix(cc);

%fifwhos labeled
RGB_label = label2rgb(labeled, @white, 'k', 'shuffle'); %set @Jet if want to overlay colormap

%overlay
I4=ind2rgb(I,gray);
Izo1=ind2rgb(Izo1,gray);
RGB=double(RGB_label);
Ix3=RGB*0+I4*0.5+Izo1; %set RGB * 0.5 if want to display colors
%figure
imshow(Ix3)

hold on
for k=1:length(B)
    boundary=B{k};
    %plot(boundary(:,2),boundary(:,1),'w','LineWidth',0.5) %plot boundary
    index_str = sprintf('%d',k);
    text(boundary(1,2),boundary(1,1),index_str,'Color','r','FontSize',10);
end

%save as tiff file with 400dpi resolution
print('-dtiff','-r400',outputFileName)

close all

end

