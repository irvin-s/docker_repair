# Use an official Python runtime as a parent image  
FROM python:3-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
CMD [ "python", "./app.py" ]  

