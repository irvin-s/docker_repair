# Use an official Python runtime as a parent image  
FROM python:2.7  
# Set the working directory to /app  
WORKDIR /app  
  
# Copy the current directory contents into the container at /app  
ADD . /app  
  
# Install any needed packages specified in requirements.txt  
RUN pip install -r requirements.txt  
  
# Create directory for OSG  
RUN mkdir -p /cvmfs  
  
# Make executable  
RUN chmod +x /app/simprily.py  
  
# Make port 80 available to the world outside this container  
EXPOSE 80  
# Define entry point  
#ENTRYPOINT ["python", "/app/simprily.py"]

