function waveletplot1D(w,J)
M=length(w);
shift=0;
for j=1:J+1
    w0=w(1:M/2);
    w=w(M/2+(1:M/2));
    col='b';
    if j==J+1
        col='r';
        text(-0.01*2^j*M/2,shift/2,'High-pass subbands','rotation',90,'verticalalignment','bottom','horizontalalignment','center')
        text(-0.01*2^j*M/2,shift*1.1+(max(w0)-min(w0))/2,'Low-pass','rotation',90,'verticalalignment','bottom','horizontalalignment','center')
        plot([1,2^j*M/2],[shift,shift]*1.05,'--k'),hold on
        shift=shift*1.1;
    end
    plot(2^j*(1:M/2),w0-min(w0)+shift,col),hold on
    shift=shift+max(w0)-min(w0);
    M=M/2;
end
set(gca,'ytick',[])
hold off