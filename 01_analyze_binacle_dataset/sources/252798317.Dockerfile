FROM ubuntu  
MAINTAINER Nik Petersen  
  
# Install Node.js and other dependencies  
RUN apt-get update && \  
apt-get -y install curl && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get -y install git-core nginx python build-essential nodejs  
  
RUN npm install -g ember-cli bower phantomjs  
RUN mkdir -p /app/dist  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY start.sh /start.sh  
  
ONBUILD COPY . /app  
ONBUILD WORKDIR /app  
ONBUILD RUN npm install  
ONBUILD RUN bower install --allow-root  
ONBUILD RUN ember build --environment=production  
  
ENTRYPOINT ["/start.sh"]  
CMD "nginx"  
  

