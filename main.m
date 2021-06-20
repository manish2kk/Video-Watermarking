filename = 'testdata.xlsx';
A ={'alpha','psnrExt','mseExt','corExt','psnrAv','mseAv','corAv','psnrRo','mseRo','corRo','psnrNg','mseNg','corNg','psnrNp','mseNp','corNp','psnrNps','mseNps','corNps','psnrBl','mseBl','corBl'};
xlRange = 'A1';
sheet = 3;
xlswrite(filename,A,sheet,xlRange);
tau  =0.3;

[images] = im_array();
for alpha=0:5
    folder=strcat('a=',int2str(alpha),')');
    [p1,m1,c1,p2,pf2,c2,p3,pf3,c3,p4,pf4,c4,p5,pf5,c5,p6,pf6, c6,p7,pf7,c7]= combine(images,folder, alpha,tau);
    A=[alpha,p1,m1,c1,p2,pf2,c2,p3,p3,c3,p4,p4,c4,p5,p5,c5,p6,p6, c6,p7,p7,c7];
    i=3+alpha;
    xlRange = strcat('A',int2str(i));
    xlswrite(filename,A,sheet,xlRange);
end

