FROM golang:latest  
  
RUN apt-get update && apt-get install -y \  
curl \  
dnsutils \  
less \  
libpcap-dev \  
locales \  
net-tools \  
nmap \  
tcpdump \  
tmux \  
vim  
  
RUN echo "set -o vi" >> $HOME/.profile  
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> $HOME/.profile  
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  
RUN locale-gen  
  
RUN go get github.com/google/gopacket  
  
ENTRYPOINT ["tmux"]  

