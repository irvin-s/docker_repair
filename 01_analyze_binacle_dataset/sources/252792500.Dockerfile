FROM ruby:2.3.0  
  
USER root  
  
RUN apt-get -y update \  
&& apt-get -y install nodejs npm git locales \  
&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \  
&& locale-gen en_US.UTF-8 \  
&& npm install -g strider-docker-slave@1.*.*  
  
RUN mkdir -p /usr/local/strider/workspace  
  
WORKDIR /usr/local/strider/workspace  
  
CMD [ "strider-docker-slave" ]  

