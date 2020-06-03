FROM docker:17  
MAINTAINER Fabio Todaro <fbregist@gmail.com>  
  
# Install dependencies  
RUN apk add --update --no-cache \  
bash \  
curl \  
ruby-json \  
libffi-dev \  
alpine-sdk \  
ruby \  
ruby-dev \  
ruby-io-console \  
zlib-dev \  
openssh \  
jq \  
groff \  
py-pip \  
python && \  
echo 'gem: --no-document' > ~/.gemrc  
  
# Install AWS-CLI  
RUN pip install --upgrade \  
pip \  
awscli  
  
# Install Chef  
RUN gem install chef  
  
# Install Berkshelf  
RUN USE_SYSTEM_GECODE=1 gem install berkshelf  
  
# Install Chef Testing tools  
RUN gem install rake foodcritic cookstyle  
  
# Clean  
RUN gem sources -c  
  
COPY scripts/* /usr/local/bin/  
  
RUN chmod a+x /usr/local/bin/*  

