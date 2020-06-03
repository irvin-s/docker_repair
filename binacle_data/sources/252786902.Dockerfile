FROM alpine:3.6  
  
RUN apk --no-cache add bash \  
bind \  
bind-tools \  
ca-certificates \  
curl \  
git \  
iperf \  
iputils \  
jq \  
mtr \  
netcat-openbsd \  
nmap \  
tcpdump \  
vim \  
wget  
  
ENTRYPOINT [ "/bin/bash" ]  

