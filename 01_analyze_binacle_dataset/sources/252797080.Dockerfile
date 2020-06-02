FROM python:2.7  
# Install software  
RUN apt-get update && apt-get install -y unzip  
  
# Create a folder for the app code.  
RUN mkdir /app  
WORKDIR /app  
  
EXPOSE 80  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod u+x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

