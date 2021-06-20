function [synth] = iFSWT(ll,lh,hl,hh,alp,ta)
[M,~]=size(ll);      % Should be a power of 2
% Choose a fractional spline wavelet transform
 alpha=alp;          % Real value larger than -0.5
 tau=ta;            % Real value between -0.5 and +0.5
 type='ortho';       % Options are:  1. 'bspline'
                    %               2. 'ortho'
                    %               3. 'dual'
[FFTanalysisfilters,FFTsynthesisfilters]=FFTfractsplinefilters(M*2,alpha,tau,type);
% Perform a fractional spline wavelet transform of the image
J=1;%3;                % Number of decomposition levels
W=zeros(2*M,2*M);
W(1:M,1:M)=ll;
W(M+1:2*M,1:M)=hl;
W(1:M,M+1:2*M)=lh;
W(1+M:2*M,1+M:2*M)=hh;

I0=FFTwaveletsynthesis2D(W,FFTsynthesisfilters,J);
I0=uint8(I0);
% Reconstruction from only one subband: use of the second output parameter
% from the function wextract2D.m
band='LL1';       
[ll,W0]=wextract2D(W,band);
I0=FFTwaveletsynthesis2D(W0,FFTsynthesisfilters,J);
I0=uint8(I0);
synth=imresize(I0,[1080 1920]);
end