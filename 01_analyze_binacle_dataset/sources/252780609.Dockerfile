FROM openjdk:8-slim  
  
# Get API key from environment variable  
ENV API_KEY="DUMMY_KEY"  
COPY ./happy-check-agent /usr/happy-check-agent  
COPY ./start.sh /usr/happy-check-agent/start.sh  
  
RUN chmod +x /usr/happy-check-agent/start.sh  
  
CMD usr/happy-check-agent/start.sh $API_KEY  

