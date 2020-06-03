FROM node:alpine  
  
# Install Server  
RUN apk --update add --no-cache curl \  
wget \  
bzip2 \  
unzip \  
bash \  
lsyncd \  
rsync \  
openssh-client \  
nmap \  
nmap-ncat \  
jq \  
python \  
make \  
g++ \  
gcc \  
ruby \  
ruby-io-console \  
ruby-json \  
ruby-bundler  
RUN apk add --update build-base libffi-dev ruby ruby-dev ca-certificates  
RUN gem install sass --no-ri --no-rdoc  
RUN apk del build-base libffi-dev ruby-dev && rm -rf /var/cache/apk/*#  

