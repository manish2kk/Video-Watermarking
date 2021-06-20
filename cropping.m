function [c1,c2,c3] = cropping(images)
p1=0.3;
p2=0.7;
p3=0.9;
q1=1/p1;
q2=1/p2;
q3=1/p3;
m=256;
[FileName1,PathName1] = uigetfile('D:/DWT_FracOrderSVD/*','Select the video to be extracted ...');
wavelet='haar';
WM=imread('D:/DWT_FracOrderSVD/watermarks/icvwatermark.jpg');
NF = size(images,1);
images1 = cell(NF,1);
c1=0;
c2=0;
c3=0;
H = fspecial('disk',2);

parfor i = 1:NF
    combinedString=strcat(int2str(i),'.jpg');
    images1{i} = imread(fullfile('D:/DWT_FracOrderSVD/WaterMarkedVideoFrames/',FileName1,combinedString));
    I2{i} = imcrop(images1{i},[10 10 246 246]);
end
tic
for j=1:NF
    %j= ceil(1 + (NF-1).*rand(1,1));
    im=I2{j};
    im=imresize(im,[m m]);
    imr=im(:,:,1);
    img=im(:,:,2);
    imb=im(:,:,3);
    [wmA1r,~,~,~] = dwt2(imr,wavelet);
    [~,~,~,wmD2r] = dwt2(wmA1r,wavelet);
    [~,wSr,~] = svd(wmD2r);
    [wmA1g,~,~,~] = dwt2(img,wavelet);
    [~,~,~,wmD2g] = dwt2(wmA1g,wavelet);
    [~,wSg,~] = svd(wmD2g);
    [wmA1b,~,~,~] = dwt2(imb,wavelet);
    [~,~,~,wmD2b] = dwt2(wmA1b,wavelet);
    [~,wSb,~] = svd(wmD2b);
    imm=images{j};
    immr=imm(:,:,1);
    immg=imm(:,:,2);
    immb=imm(:,:,3);
    [cA1mr,~,~,~] = dwt2(immr,wavelet);
    [~,~,~,cD2mr] = dwt2(cA1mr,wavelet);
    [~,cSmr,~] = svd(cD2mr);
    [cA1mg,~,~,~] = dwt2(immg,wavelet);
    [~,~,~,cD2mg] = dwt2(cA1mg,wavelet);
    [~,cSmg,~] = svd(cD2mg);
    [cA1mb,~,~,~] = dwt2(immb,wavelet);
    [~,~,~,cD2mb] = dwt2(cA1mb,wavelet);
    [~,cSmb,~] = svd(cD2mb);
      [a b c]=size(WM);
     if(c==3)
        W = rgb2gray(WM);
    else
       W = WM; 
    end
     W=imresize(W,[m m]);
    [A1,H1,V1,D1] = dwt2(W,wavelet);
    [A2,H2,V2,D2] = dwt2(A1,wavelet);
    [U,~,V] = svd(D2);
    extr = (wSr-cSmr).^2;
    extg = (wSg-cSmg).^q2;
    extb = (wSb-cSmb).^q3;
    Wmextr = U*extr*V';
    Wmextg = U*extg*V';
    Wmextb = U*extb*V';
    w1r = idwt2(A2,H2,V2,Wmextr,wavelet);
    w2r = idwt2(w1r,H1,V1,D1,wavelet);
    w1g = idwt2(A2,H2,V2,Wmextg,wavelet);
    w2g = idwt2(w1g,H1,V1,D1,wavelet);
    w1b = idwt2(A2,H2,V2,Wmextb,wavelet);
    w2b = idwt2(w1b,H1,V1,D1,wavelet);
    
    %psnr_wm_frame = psnr_wm_frame+psnr(images1{j},im);
    %mse_wm_frame  =mse_wm_frame+ mse(images1{j},im);
    c1=c1+corr2(uint8(w2r),W);
    c2=c2+corr2(real(uint8(w2g)),W);
    c3=c3+corr2(real(uint8(w2b)),W);
end
toc
c1=c1/NF;
c2=c2/NF;
c3=c3/NF;
total=(c1+c2+c3)/3
imshow(real(uint8(w2r)));
end