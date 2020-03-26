FROM debian:jessie  
  
RUN apt-get update  
RUN apt-get install -y npm time  
  
ENV NEXE_VERSION=0.4.1  
ENV NODEJS_VERSION=latest  
ENV LDFLAGS="-static-libgcc -static-libstdc++"  
RUN npm install -g nexe@${NEXE_VERSION}  
RUN ln -sf /usr/bin/nodejs /usr/bin/node  
  
RUN echo "console.log('test')" > app.js \  
&& time nexe -r "$NODEJS_VERSION" -i app.js -o app.bin \  
&& rm app.js && rm app.bin  
  
WORKDIR /app  
  
ADD docker-entrypoint /usr/sbin/docker-entrypoint  
  
ENTRYPOINT "/usr/sbin/docker-entrypoint"  

