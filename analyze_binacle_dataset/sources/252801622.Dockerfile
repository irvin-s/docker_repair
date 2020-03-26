# Base image from: https://hub.docker.com/_/python/  
FROM python:2  
# Set the working directory to /app  
# WORKDIR /app  
# Copy webservice clients  
COPY *.py /app/bin/  
  
# Copy Travis test script  
COPY cmd-travis.sh /app/bin/  
  
# Make clients executable  
RUN chmod +x /app/bin/*  
  
# Add /app/bin to PATH  
ENV PATH="/app/bin:${PATH}"  
# Install any needed packages specified in requirements.txt  
COPY requirements.txt /app  
RUN pip install -r /app/requirements.txt  
  
# Set the working directory  
WORKDIR /app/work  

