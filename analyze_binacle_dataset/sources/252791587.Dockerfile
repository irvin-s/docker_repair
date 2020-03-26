FROM alpine  
LABEL maintainer="Daniel Davidson"  
  
COPY src /opt/src  
  
RUN apk add --no-cache --update-cache \  
bash \  
docker \  
nodejs \  
nodejs-npm && \  
npm install -g nodemon  
  
EXPOSE 3000/tcp  
  
WORKDIR /opt/src  
  
CMD ["nodemon", "server.js"]

