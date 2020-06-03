FROM alpine:3.4  
RUN apk --no-cache add \  
\--repository http://dl-1.alpinelinux.org/alpine/edge/testing/ \  
tini=0.9.0-r1 \  
bash=4.3.42-r3  
  
ENTRYPOINT ["/sbin/tini", "--"]  
CMD ["bash"]  

