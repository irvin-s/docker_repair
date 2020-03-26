# Use an official Python runtime as a parent image  
FROM python:3.6-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
# Copy the current directory contents into the container at /app  
ADD . /app  
  
# Install any needed packages specified in requirements.txt  
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt  
  
# Make port 80 available to the world outside this container  
EXPOSE 80  
# Define environment variable  
ENV NAME World  
  
# Run server.py when the container launches  
CMD ["python3", "server.py"]  

