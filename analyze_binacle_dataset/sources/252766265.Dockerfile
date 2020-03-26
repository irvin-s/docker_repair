FROM alpine:3.7  
RUN apk add --update nodejs  
  
COPY . /app  
WORKDIR /app  
  
RUN npm install -g mocha && \  
npm install  
  
ENTRYPOINT ["mocha"]  

