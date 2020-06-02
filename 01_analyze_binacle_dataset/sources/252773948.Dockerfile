FROM mhart/alpine-node:latest  
  
WORKDIR /src  
ADD . .  
  
RUN apk --update add make gcc g++ python git \  
&& npm install --production \  
&& apk del make gcc g++ python git \  
&& rm -rf /tmp/* /root/.npm /root/.node-gyp /var/cache/apk/*  
  
ENTRYPOINT ["node"]  
  
CMD ["index.js"]

