FROM alpine:edge  
RUN apk add --update \  
# Basic shell stuff  
bash \  
bash-completion \  
readline \  
grep \  
gawk \  
tree \  
# Interacting with the networks  
curl \  
wget \  
jq \  
drill \  
nmap \  
netcat-openbsd \  
socat \  
# Monitoring / Shell tools  
htop \  
mc \  
# Development tools  
vim \  
tmux \  
git \  
tig \  
# Scripting languages  
ruby \  
ruby-irb \  
nodejs \  
&& \  
rm -rf /var/cache/apk/*  
  
COPY dotfiles/* /root/  
ENTRYPOINT ["bash"]  

