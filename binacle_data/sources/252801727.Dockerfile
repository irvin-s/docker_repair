FROM node:8.4.0-alpine  
  
WORKDIR /app  
COPY . /app/  
  
RUN set -ex && \  
buildDeps=' \  
make \  
gcc \  
g++ \  
python \  
py-pip \  
' && \  
runDeps=' \  
curl \  
openssl \  
' && \  
apk add --no-cache \  
\--virtual .build-deps $buildDeps && \  
apk add --no-cache \  
\--virtual .run-deps $runDeps && \  
npm install && \  
npm install --silent --save-dev -g \  
gulp-cli \  
typescript && \  
tsc --target es5 connector.ts && \  
rm -fr /app/package.json /app/*.ts && \  
apk del .build-deps  
  
ENTRYPOINT ["node"]  
CMD ["connector.js"]  

