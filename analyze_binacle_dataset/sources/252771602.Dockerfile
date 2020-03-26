FROM node:0.10.36  
RUN mkdir -p /node_app  
  
WORKDIR /node_app  
  
ADD ./ /node_app  
  
RUN npm install  
RUN npm install -g serve  
  
RUN chmod +x /node_app/start_firebase_listener.sh  
  
EXPOSE 8080  
ENTRYPOINT /node_app/start_firebase_listener.sh  

