FROM ubuntu:latest  
MAINTAINER Brandfolder Developers <developers@brandfolder.com>  
  
# S3 configuration  
ENV AWS_ACCESS_KEY_ID=NotSet  
ENV AWS_SECRET_ACCESS_KEY=NotSet  
ENV S3_BUCKET=NotSet  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update  
RUN apt-get -y install openssh-server  
RUN apt-get -y install build-essential git libfuse-dev libcurl4-openssl-dev \  
libxml2-dev mime-support automake libtool pkg-config libssl-dev fuse  
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse && \  
cd s3fs-fuse && \  
./autogen.sh && \  
./configure --prefix=/usr --with-openssl && \  
make && \  
make install  
  
RUN mkdir -p /var/run/sshd  
  
COPY entrypoint /  
COPY sshd_config /etc/ssh/sshd_config  
RUN chmod +x /entrypoint  
  
EXPOSE 22  
ENTRYPOINT ["/entrypoint"]  

