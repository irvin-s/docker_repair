FROM busybox  
LABEL maintainer="jim.robinson@croud.co.uk"  
LABEL vendor="Croud Inc Ltd"  
  
COPY make-swap /usr/bin/make-swap  
  
ENV SWAPSIZE=512 SWAPFILE=/var/lib/swap.img  
  
CMD ["/usr/bin/make-swap"]

