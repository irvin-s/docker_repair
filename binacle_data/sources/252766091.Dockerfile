FROM aafrey/fwatchdog:alpine  
RUN apk add --no-cache nodejs && \  
npm install -g coffee-script  
  
ADD . /  
RUN npm install  
  
ENV fprocess="coffee index.coffee"  
CMD ["fwatchdog"]  

