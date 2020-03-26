FROM rocketchat/rocket.chat  
  
ENV MONGO_OPLOG_URL=mongodb://mongo:27017/local  
COPY ./scripts/ .  
  
USER root  
RUN chown 1000:1000 start.sh && chmod +x start.sh  
USER 1000  
  
CMD "./start.sh"  

