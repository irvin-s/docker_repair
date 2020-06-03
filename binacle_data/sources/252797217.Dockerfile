FROM mhart/alpine-node:latest  
  
WORKDIR /src  
ADD . .  
  
RUN apk --update add make git gcc g++ python \  
&& npm install --production \  
&& apk del make git gcc g++ python \  
&& rm -rf /tmp/* /root/.npm /root/.node-gyp /var/cache/apk/*  
  
ENV NODE_ENV=production  
  
CMD ["node", "/src/nats.js"]

