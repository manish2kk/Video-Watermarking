function embedding(images)
p1=0.1;
p2=0.7;
p3=0.9;
m=256;
[FileName1,PathName1] = uigetfile('D:/DWT_FracOrderSVD/*','Select the video to be watermarked ...');
wavelet='haar';
numframe = size(images,1);
combinedString=strcat('D:/DWT_FracOrderSVD/WaterMarkedVideoFrames/',FileName1);
mkdir(combinedString);
WM=imread('D:\DWT_FracOrderSVD\watermarks\icvwatermark.jpg');
tic
for i=1:numframe
    im=images{i};
    imr=im(:,:,1);
    img=im(:,:,2);
    imb=im(:,:,3);
    [cA1r,cH1r,cV1r,cD1r] = dwt2(imr,wavelet);
    [cA2r,cH2r,cV2r,cD2r] = dwt2(cA1r,wavelet);
    [Ur,Sr,Vr] = svd(cD2r);
    [cA1g,cH1g,cV1g,cD1g] = dwt2(img,wavelet);
    [cA2g,cH2g,cV2g,cD2g] = dwt2(cA1g,wavelet);
    [Ug,Sg,Vg] = svd(cD2g);
    [cA1b,cH1b,cV1b,cD1b] = dwt2(imb,wavelet);
    [cA2b,cH2b,cV2b,cD2b] = dwt2(cA1b,wavelet);
    [Ub,Sb,Vb] = svd(cD2b);
    [a b c]=size(WM);
    if(c==3)
        W = rgb2gray(WM);
    else
       W = WM; 
    end
    W=imresize(W,[m m]);
    [wA1,~,~,~] = dwt2(W,wavelet);
    [~,~,~,wD2] = dwt2(wA1,wavelet);
    [~,WS,~] = svd(double(wD2));
    Sr = Sr + WS.^p1;
    Sg = Sg + WS.^p2;
    Sb = Sb + WS.^p3;
    Wdwtframer = Ur*Sr*Vr';    
    Wdwtframeg = Ug*Sg*Vg';
    Wdwtframeb = Ub*Sb*Vb';
    imw1r = idwt2(cA2r,cH2r,cV2r,Wdwtframer,wavelet);
    imw2r = idwt2(imw1r,cH1r,cV1r,cD1r,wavelet);
    imw1g = idwt2(cA2g,cH2g,cV2g,Wdwtframeg,wavelet);
    imw2g = idwt2(imw1g,cH1g,cV1g,cD1g,wavelet);
    imw1b = idwt2(cA2b,cH2b,cV2b,Wdwtframeb,wavelet);
    imw2b = idwt2(imw1b,cH1b,cV1b,cD1b,wavelet);
    im(:,:,1)=imw2r;
    im(:,:,2)=imw2g;
    im(:,:,3)=imw2b;
    combinedString=strcat('D:/DWT_FracOrderSVD/WaterMarkedVideoFrames/',FileName1,'/',int2str(i),'.jpg');
    imwrite(im,combinedString);
   
end
toc
end