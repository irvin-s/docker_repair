FROM node:7.9.0-alpine  
MAINTAINER Grégoire Weber <gregoire@barracks.io>  
  
ENV DEBUG 0  
ENV BARRACKS_BASE_URL "https://app.barracks.io"  
ENV BARRACKS_ENABLE_V2 0  
ENV BARRACKS_ENABLE_EXPERIMENTAL 0  
WORKDIR /usr/local/lib/barracks-cli  
  
COPY package.json .  
RUN npm install  
COPY src/ src/  
RUN ln -s /usr/local/lib/barracks-cli/src/bin/barracks /usr/local/bin/barracks  
  
WORKDIR /  
  
ENTRYPOINT ["barracks"]  

