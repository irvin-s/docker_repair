FROM ubuntu:latest  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
ADD https://github.com/carlwoodward/disco/archive/master.zip /master.zip  
RUN echo "Install" && \  
apt-get update && \  
apt-get install -y ruby unzip python && \  
gem install sass && \  
unzip /master.zip && \  
mv /disco-master /code && \  
rm /master.zip && \  
cd /code && \  
sass --update web/sass:web/css || true  
  
EXPOSE 8080  
WORKDIR /code/web  
USER nobody  
CMD python -m SimpleHTTPServer 8080  

