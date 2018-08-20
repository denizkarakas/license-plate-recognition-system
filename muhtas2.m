clear all;clc;close all;
org_image=imread('plaka.png');
figure
imshow(org_image);
title('original image');
ylpf=imfilter(org_image,fspecial('average',[3 3]));
figure
imshow(ylpf);
title('output of low pass filter');
% Histogram esitlemede imgenin 2 boyutlu olmasý beklenir.Imge üç boyutlu
% oldugu icin ilk once grayscale'e cevirdik
grey_img=rgb2gray(org_image);
img_histeq=histeq(grey_img);
figure
imshow(img_histeq);
title('histogram esitleme sonucu');
% Dogrusal yayma
i=org_image(:,:,1);
rtemp=min(i);
rmin=min(rtemp);
rtemp=max(i);
rmax=max(rtemp);
m=255/(rmax-rmin);
c=255-m*rmax;
i_new=m*i + c;
figure
imshow(i_new);
 bw_img=im2bw(i_new,0.9);
figure
imshow(bw_img);
imagen = bwareaopen(bw_img,30);
figure
imshow(~imagen);
%ara rapor sonrasý

[L, Ne]=bwlabel(imagen);%Ne=, nesne tespit edildi
%% Measure properties of image regions
propied=regionprops(L,'BoundingBox');
hold on
%% Plot Bounding Box
for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)
%% Objects extraction
figure
for n=1:Ne
      [r,c] = find(L==n);
      n1=imagen(min(r):max(r),min(c):max(c));
%       imshow(~n1);    
%       figure
%       pause(0.5)
       
end
    
    arr=[];
    newarr=[];
for i=1:Ne
    arr(i,:)=propied(i).BoundingBox;
    newarr(i,:)=arr(i,3:4);
end

        
for i=1:Ne
    if(newarr(i,1)/newarr(i,2)>=4.3 && newarr(i,1)/newarr(i,2)<=5.2 )
        
    [r,c] = find(L==i);
      n2=imagen(min(r):max(r),min(c):max(c));
      imshow(~n2);    
    end
end




%%%%%%%%%%%


[L1, Ne1]=bwlabel(~n2);
propied1=regionprops(L1,'BoundingBox');
hold on
%% Plot Bounding Box
for n=1:size(propied1,1)
      rectangle('Position',propied1(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)

figure
for n=1:Ne1
      [r1,c1] = find(L1==n);
      n3=n2(min(r1):max(r1),min(c1):max(c1));
%       imshow(n3);    
%       figure
%       pause(0.5)
       
end
 arr1=[];
    newarr1=[];
for i=1:Ne1
    arr1(i,:)=propied1(i).BoundingBox;
    newarr1(i,:)=arr1(i,3:4);
end
for i=1:Ne1
    if(newarr1(i,1)/newarr1(i,2)>=0.630 && newarr1(i,1)/newarr1(i,2)<=0.690 )
        
    [r1,c1] = find(L1==i);
      n4=n2(min(r1):max(r1),min(c1):max(c1));
       figure
       imshow(n4);   
      pause(0.5)
    end
end

