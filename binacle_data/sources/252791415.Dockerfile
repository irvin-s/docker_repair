#########################################################################################  
# Dockerfile used to automatically build the movierater-movieinfoAPI service  
# Based on ubuntu 14.04.4  
#########################################################################################  
  
# Set the base image as ubuntu 14.04.4  
FROM ubuntu:14.04.4  
  
# Add the current folder  
ADD . /movierater-movieinfoAPI  
  
# Update the apt repository and install some required packages  
RUN apt-get update && apt-get install -y python python-pip nano  
  
# Install required python packages  
RUN pip install Flask requests  
  
# Set the pythonpath  
ENV PYTHONPATH=/movierater-movieinfoAPI/  
  
# Expose port 5000  
EXPOSE 5000  
  
# Start the api  
CMD ["python", "/movierater-movieinfoAPI/api/app.py"]

