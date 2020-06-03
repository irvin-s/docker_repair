FROM alpine:3.5  
RUN apk add --no-cache docker nodejs bash findutils libewf  
  
RUN echo '{ "allow_root": true }' > /root/.bowerrc  
  
COPY ./ /root/iped-queue/  
WORKDIR /root/iped-queue/  
  
RUN npm install  
  
CMD ["npm", "start"]  

