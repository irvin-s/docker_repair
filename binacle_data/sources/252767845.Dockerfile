FROM acrisliu/lede  
MAINTAINER Acris Liu "acrisliu@gmail.com"  
COPY diffconfig /tmp  
RUN cp /tmp/diffconfig .config && make defconfig  
CMD ["make"]  

