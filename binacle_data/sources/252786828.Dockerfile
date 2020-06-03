FROM python:3-onbuild  
MAINTAINER bowwow "bowwow@bowwow.com"  
RUN \  
apt-get update && \  
apt-get install -y libav-tools && \  
rm -rf /var/lib/apt/lists/* && \  
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz && \  
tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz && \  
cd /usr/local/bin && \  
ln -s ../go/bin/* .  
  
ENV GOROOT "/usr/local/go"  
ENV GOPATH "/home/mygo"  
EXPOSE 7777  
VOLUME ["/data"]  
WORKDIR /data  
  
CMD ["youtube64linux"]  

