# Starting from Python 3 base image  
FROM python:3  
MAINTAINER Prantar <prantarbhowmik@yhaoo.com>  
  
# Set the WORKDIR to /app so all following commands run in /app  
WORKDIR /app  
  
RUN apt-get update && apt-get install -y python3-pip  
  
RUN pip3 install pytest  
  
# Adding the whole repository to the image  
COPY . ./  
  
CMD ["python3", "-m", "pytest"]  

