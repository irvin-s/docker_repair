FROM alpine:latest  
  
MAINTAINER Hantzley Tauckoor <hantzley@gmail.com>  
  
RUN apk add --update \  
bash \  
curl \  
vim \  
nano \  
git \  
python3 \  
python-dev \  
py-pip \  
build-base \  
perl \  
&& pip3 install --upgrade pip \  
&& pip3 install virtualenv virtualenvwrapper \  
flask flask-sijax requests urllib3 \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir -p /cisco-gve  
  
VOLUME /cisco-gve  
WORKDIR /cisco-gve  
ADD setup.sh /bin  
RUN chmod +x /bin/setup.sh  
  
CMD ["bash"]  

