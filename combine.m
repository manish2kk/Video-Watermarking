function [p1,m1,c1,p2,pf2,c2,p3,pf3,c3,p4,pf4,c4,p5,pf5,c5,p6,pf6, c6,p7,pf7,c7]= combine(images,folder, alpha,tau)
%embedding(images,folder,alpha,tau);
[p1,m1,c1] = extracting(images,folder,alpha,tau)
[p2,pf2,c2] = frameaveraging(images,folder,alpha,tau)
[p3,pf3,c3] = framerotate(images,folder,alpha,tau)
[p4,pf4,c4,p5,pf5,c5,p6,pf6, c6] = noise(images,folder,alpha,tau)
[p7,pf7,c7] = blurring(images,folder,alpha,tau)
end