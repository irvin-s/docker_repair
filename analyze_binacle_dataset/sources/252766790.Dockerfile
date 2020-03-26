# Use python as parent image  
FROM python  
  
# Update apt-get and install curl  
RUN apt-get update && apt-get install curl -y  

