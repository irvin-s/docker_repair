FROM alpine:latest  
  
RUN apk add --no-cache \  
curl \  
bash \  
jq \  
git \  
netcat-openbsd \  
ruby \  
ruby-dev \  
ruby-bundler \  
ruby-json \  
openssh-client \  
expect \  
python2 \  
python3 \  
py2-pip \  
mariadb-dev \  
build-base \  
rsync \  
mysql-client \  
openssl \  
&& pip3 install awscli  

