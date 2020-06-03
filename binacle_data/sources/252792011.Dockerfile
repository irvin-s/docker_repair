FROM debian:latest  
MAINTAINER Chad Peterson chapeter@cisco.com  
  
RUN apt-get update && apt-get install -y \  
aufs-tools \  
automake \  
build-essential \  
curl \  
dpkg-sig \  
mercurial \  
&& rm -rf /var/lib/apt/lists/*  
  
EXPOSE 80  
COPY hello_world.sh /root/  
RUN chmod +x /root/hello_world.sh  
  
CMD ["/root/hello_world.sh"]  

