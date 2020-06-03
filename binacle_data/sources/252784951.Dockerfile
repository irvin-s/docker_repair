FROM node:carbon-alpine  
ARG DEP_VERSION=latest  
LABEL maintainer="butlerx <cian@coderdojo.org>"  
ENV NODE_ENV=production  
RUN apk add --update git build-base python postgresql-client && \  
mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
RUN yarn && \  
yarn add cp-translations@"$DEP_VERSION" && \  
apk del build-base python && \  
rm -rf /tmp/* /root/.npm /root/.node-gyp  
EXPOSE 10307  
CMD ["yarn", "start"]  

