function [ll,lh,hl,hh] = FSWT(I,alp,ta)

I=imresize(I,[1024,1024]);
[M,~]=size(I);      % Should be a power of 2
% Choose a fractional spline wavelet transform
 alpha=alp;          % Real value larger than -0.5
 tau=ta;            % Real value between -0.5 and +0.5
 type='ortho';       % Options are:  1. 'bspline'
                    %               2. 'ortho'
                    %               3. 'dual'
[FFTanalysisfilters,FFTsynthesisfilters]=FFTfractsplinefilters(M,alpha,tau,type);

% Perform a fractional spline wavelet transform of the image
J=1;%3;                % Number of decomposition levels
W=FFTwaveletanalysis2D(I,FFTanalysisfilters,J);

% Show a subband
band='HH1';       
hh=wextract2D(W,band);

band='LH1';       
lh=wextract2D(W,band);

band='HL1';       
hl=wextract2D(W,band);

band='LL1';       
ll=wextract2D(W,band);
% Show the whole wavelet transform

% Reconstruction of the image from its wavelet transform
I0=FFTwaveletsynthesis2D(W,FFTsynthesisfilters,J);
I0=uint8(I0);

% Reconstruction from only one subband: use of the second output parameter
% from the function wextract2D.m
band='LL1';       
[hh,W0]=wextract2D(W,band);
I0=FFTwaveletsynthesis2D(W0,FFTsynthesisfilters,J);

end