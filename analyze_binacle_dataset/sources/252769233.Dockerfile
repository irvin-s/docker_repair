FROM node:9.1.0-alpine as builder  
RUN apk add --no-cache git  
WORKDIR /app  
RUN git clone https://github.com/OmerTu/GoogleHomeKodi  
RUN cd GoogleHomeKodi && npm install  
  
FROM node:9.1.0-alpine  
COPY \--from=builder /app /app  
CMD ["node", "server.js"]  

