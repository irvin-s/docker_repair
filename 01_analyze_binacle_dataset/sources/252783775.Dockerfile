FROM debian  
  
WORKDIR /usr/src/go  
ENV GOPATH /usr/src/go  
  
RUN apt-get -y update && apt-get -y install golang git-core gcc \  
&& go get -u github.com/odeke-em/drive/cmd/drive \  
&& cp bin/drive /bin/ \  
&& cd / && rm -rf /usr/src/go \  
&& apt-get -y purge golang git-core gcc \  
&& apt-get -y autoremove \  
&& apt-get -y clean  
  
WORKDIR /  
ENTRYPOINT ["/bin/drive"]  

