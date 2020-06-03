FROM node:latest  
  
ENV NEXE_VERSION=1.1.2  
ENV NODEJS_VERSION=latest  
ENV LDFLAGS="-static-libgcc -static-libstdc++"  
RUN npm install -g nexe@${NEXE_VERSION}  
RUN ln -sf /usr/bin/nodejs /usr/bin/node  
  
WORKDIR /app  
  
CMD "nexe"  

