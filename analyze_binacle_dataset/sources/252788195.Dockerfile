FROM python:3.5  
MAINTAINER Craig Weber <crgwbr@gmail.com>  
  
# Install Flower  
ENV FLOWER_VERSION='0.9.1'  
RUN pip install flower==$FLOWER_VERSION && pip install redis  
  
# Expose port 5555 so that we can connect to it  
EXPOSE 5555  
# Run Flower  
CMD ["flower", "--port=5555"]  

