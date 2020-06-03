FROM debian:stable-slim  
MAINTAINER Michal Belica <devel@beli.sk>  
EXPOSE 9876  
ENV GOPATH /gocode  
RUN apt-get update && apt-get install -y golang-go git ca-certificates \  
&& mkdir /gocode \  
&& mkdir /etc/sachet \  
&& go get github.com/messagebird/sachet/cmd/sachet \  
&& apt-get purge -y --auto-remove golang-go git \  
&& rm -rf /gocode/src /gocode/pkg \  
&& apt-get clean && rm -rf /var/lib/apt/lists  
COPY config.yaml /etc/sachet/config.yaml  
COPY entrypoint /entrypoint  
CMD ["/entrypoint"]  

