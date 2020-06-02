##  
## Base  
##  
FROM node:alpine AS base  
RUN apk add \--no-cache nodejs-current tini  
ENV HOME=/home/app  
RUN addgroup -S app && \  
adduser -S -h $HOME -s /bin/false -G app app  
USER app  
WORKDIR $HOME  
ENTRYPOINT ["/sbin/tini", "--"]  
  
##  
## Production dependencies  
##  
FROM base AS production-dependencies  
COPY package.json setup-node-env.sh ./  
RUN touch current.env && \  
mkdir server lib acceptance fixtures migrations && \  
npm set progress=false && \  
npm config set depth 0 && \  
npm install \--only=production  
  
##  
## Test packages  
##  
FROM production-dependencies AS test-base  
USER root  
RUN apk add \--no-cache python make g++  
USER app  
  
##  
## Test dependencies  
##  
FROM test-base AS test-dependencies  
RUN npm set progress=false && \  
npm config set depth 0 && \  
npm install  
  
##  
## Test  
##  
FROM test-dependencies AS test  
COPY . ./  
RUN npm test  
  
##  
## Production  
##  
FROM production-dependencies AS production  
COPY . ./  
EXPOSE 3000  
CMD ["npm", "start"]  

