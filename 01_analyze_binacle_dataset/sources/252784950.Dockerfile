FROM mhart/alpine-node:0.10.48  
MAINTAINER butlerx <butlerx@notthe.cloud>  
ARG DEP_VERSION=latest  
RUN apk add --update git python build-base postgresql-client openssl && \  
mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app/  
RUN npm install && \  
npm install cp-translations@"$DEP_VERSION" && \  
apk del build-base python && \  
rm -rf /tmp/* /root/.npm /root/.node-gyp  
EXPOSE 10301  
CMD ["npm", "start"]  

