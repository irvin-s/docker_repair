# Use an official Python runtime as a parent image  
FROM python:3.6-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
# Copy the current directory contents into the container at /app  
ADD . /app  
  
# Install any needed packages specified in requirements.txt  
RUN apt-get update && apt-get install -y gcc software-properties-common  
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt  
  
# Make port 80 available to the world outside this container  
# Define environment variable  
ENV IFACE enp3s0  
  
# Run app.py when the container launches  
CMD python3 capture.py --kafka-address=$KAFKA_ADDRESS  

