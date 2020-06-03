FROM alpine:latest  
  
RUN apk update && \  
apk add \  
sudo \  
bash  
  
RUN adduser -s /bin/bash -D docker  
RUN addgroup docker wheel  
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel  
  
USER docker  
WORKDIR /home/docker  
  
CMD ["/bin/bash"]  

