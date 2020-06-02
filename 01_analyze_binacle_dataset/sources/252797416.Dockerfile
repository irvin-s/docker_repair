FROM gliderlabs/alpine:3.4  
MAINTAINER Curtis Mattoon <cmattoon@cmattoon.com>  
RUN apk add \--update --no-cache \  
ca-certificates \  
git \  
python \  
py-pip \  
&& \  
pip install --upgrade pip bumpversion  
  
VOLUME ["/test"]  
WORKDIR /test  
RUN git config \--global user.email "bumpversion@docker.nxdomain"  
RUN git config \--global user.name "Docker BumpVersion"  
CMD ["bumpversion", "patch"]  

