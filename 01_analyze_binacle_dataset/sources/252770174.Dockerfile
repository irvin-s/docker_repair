FROM gliderlabs/alpine:latest  
  
ENV LANG en_US.UTF-8  
COPY build /tmp/build  
RUN cd /tmp/build && ./mkimage.sh  
  
CMD ["/bin/bash"]  

