FROM node:8-alpine  
MAINTAINER CoderDojo Foundation <webteam@coderdojo.org>  
ARG DEP_VERSION=latest  
RUN apk add --update git make gcc g++ python && \  
mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
RUN yarn && \  
yarn add cp-translations@latest && \  
apk del make gcc g++ python && \  
rm -rf /tmp/* /root/.npm /root/.node-gyp  
EXPOSE 10305  
CMD ["yarn", "start"]  

