FROM node:9-alpine  
LABEL maintainer="Ben Selby <benmatselby@gmail.com>"  
  
RUN apk update && \  
apk add make  
  
WORKDIR /usr/src/baldrick  
COPY . .  
  
RUN make clean install  
  
CMD [ "node", "index.js" ]  

