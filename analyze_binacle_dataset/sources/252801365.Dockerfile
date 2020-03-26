FROM mhart/alpine-node  
  
ENV HOME /tmp  
ENV NODE_ENV development  
  
WORKDIR /app  
  
RUN apk add --no-cache bash python build-base git && \  
npm i -g coffee-script supervisor yarn && \  
npm cache clean --force && rm -rf /tmp/*  
  
CMD bash  

