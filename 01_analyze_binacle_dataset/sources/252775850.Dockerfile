FROM python:3.6-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
ADD ./requirements.txt /app/requirements.txt  
  
# Install any needed packages specified in requirements.txt  
RUN pip install -r requirements.txt  
  
# Copy the current directory contents into the container at /app  
ADD . /app  
  
# Make port 80 available to the world outside this container  
EXPOSE 80  
# Run app.py when the container launches  
CMD bash run.sh  
  

