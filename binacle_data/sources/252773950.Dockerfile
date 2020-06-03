FROM mhart/alpine-node:8  
WORKDIR /src  
ADD . .  
  
RUN apk --update add make gcc g++ python git \  
&& npm install --production \  
&& apk del make gcc g++ python git \  
&& rm -rf /tmp/* /root/.npm /root/.node-gyp /var/cache/apk/*  
  
FROM mhart/alpine-node:8  
RUN apk --update add bash  
  
WORKDIR /src  
  
COPY \--from=0 /src .  
  
ENTRYPOINT ["node"]  
  
CMD ["index.js"]

