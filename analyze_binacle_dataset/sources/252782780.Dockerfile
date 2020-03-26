# Use an official Python runtime as a parent image  
FROM python:3.4  
# Set python to be unbuffered  
ENV PYTHONUNBUFFERED 1  
# Set the working directory to /app  
WORKDIR /app  
  
# Copy the necessary files into the container at /app  
ADD . /app  
  
# Install any needed packages specified in requirements.txt  
RUN pip install -r requirements.txt  
  
# Set the working directory to /app/kodex  
WORKDIR kodex  
  
# Make port 8000 available to the world outside this container  
EXPOSE 8000  
# Set volume to map to host for persistent content  
VOLUME ["/app/kodex/persistent"]  
  
# Launch entry point script when the container starts  
ENTRYPOINT ["/app/helper/docker_entrypoint.sh"]  

