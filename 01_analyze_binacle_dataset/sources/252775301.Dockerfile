FROM beevelop/nodejs  
  
ENV NODE_ENV=prod  
  
WORKDIR /opt/kin-client  
  
RUN apt-get update && \  
apt-get install -y git bzip2 gettext-base --no-install-recommends && \  
npm i -g http-server && \  
git clone https://github.com/KinToday/kin-web-client . && \  
npm i  
  
COPY generate-certificate.sh ./certs/  
COPY launch.sh config.js ./  
  
CMD ./launch.sh  
  
EXPOSE 8080  

