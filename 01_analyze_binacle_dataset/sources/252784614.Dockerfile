FROM blackikeeagle/alpine:stable  
MAINTAINER Ike Devolder, ike.devolder@gmail.com  
  
COPY ./root /  
  
RUN /container/install-dnsmasq.sh  
  
WORKDIR /work/  
  
ENV DOCKER_HOST unix:///var/run/docker.sock  
  
EXPOSE 53/udp 53  
CMD ["supervisord", "-c", "supervisord.conf"]  

