FROM node:8-alpine  
MAINTAINER butlerx <butlerx@notthe.cloud>  
ENV NODE_ENV=production  
RUN apk add --update git build-base python postgresql-client && \  
mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app/  
RUN yarn && \  
yarn add cp-translations@latest && \  
apk del build-base python && \  
rm -rf /tmp/* /root/.npm /root/.node-gyp  
EXPOSE 10303  
CMD ["yarn", "start"]  

