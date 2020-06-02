FROM ubuntu:16.04  
MAINTAINER crazybit <crazybit.github@gmail.com>  
  
## Core Utilities  
RUN apt-get update && \  
apt-get -y upgrade &&\  
apt-get install -y curl git nginx && \  
curl -sL https://deb.nodesource.com/setup_6.x |bash - &&\  
apt-get install -y nodejs && \  
npm install -g webpack && \  
git clone http://github.com/bitshares/bitshares-ui /build  
  
WORKDIR /build  
RUN cd web && npm install  
  
WORKDIR /build/web  
RUN npm run build  
  
RUN mkdir /www  
RUN cp -rv /build/web/dist/* /www/  
  
ADD nginx.conf /etc/nginx/nginx.conf  
  
# Append "daemon off;" to the beginning of the configuration  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
# Expose ports  
EXPOSE 80  
# Set the default command to execute  
# when creating a new container  
CMD service nginx start  

