# Use an official Python runtime as a parent image  
FROM python:3.6.4-slim  
  
# Force the binary layer of the stdout and stderr streams to be unbuffered  
ENV PYTHONUNBUFFERED 1  
# Base directory for the application  
# Also used for user directory  
ENV APP_ROOT /home/lister  
  
# Containers should NOT run as root  
# (as good practice)  
RUN useradd -c 'Container user' -m -d ${APP_ROOT} -s /bin/bash lister  
WORKDIR ${APP_ROOT}  
  
# Copy the current directory contents into the container at /app  
COPY app.py ${APP_ROOT}  
COPY requirements.txt ${APP_ROOT}  
RUN chown -R lister.lister ${APP_ROOT}  
  
# Install any needed packages specified in requirements.txt  
RUN pip install -r requirements.txt  
  
USER lister  
ENV HOME ${APP_ROOT}  
  
# Run app.py when the container launches.  
# Need a full path for OpenShift environment.  
CMD ["python", "/home/lister/app.py"]  

