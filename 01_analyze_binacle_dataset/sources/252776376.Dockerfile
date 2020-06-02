FROM python:2  
# Ensure that Python outputs everything that's printed inside  
# the application rather than buffering it.  
ENV PYTHONUNBUFFERED 1  
# Creation of the workdir  
RUN mkdir /code  
  
WORKDIR /code  
  
# Add requirements.txt file to container  
ADD requirements.txt /code/  
  
# Install requirements  
RUN pip install --upgrade pip  
  
RUN pip install -r requirements.txt  
  
# Add the current directory(the web folder) to Docker container  
EXPOSE 3004  
ADD . /code/  
  

