FROM ubuntu:trusty  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
COPY error.sh /home/docker/error  
RUN chmod a+x /home/docker/error  
  
USER docker  
WORKDIR /home/docker  
  
CMD ["/home/docker/error"]  

