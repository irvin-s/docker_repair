############################################################  
# Dockerfile to build Python WSGI Application Containers  
# Based on Ubuntu  
############################################################  
  
# Set the base image to Ubuntu  
FROM kaixhin/theano  
  
# File Author / Maintainer  
MAINTAINER David Mack  
  
ADD build /build  
RUN pip install -r /build/requirements.txt  
  
# Copy the application folder inside the container  
ADD src /src  
  
# Expose ports  
EXPOSE 80  
  
# Set the default directory where CMD will execute  
WORKDIR /src  
  
# Set the default command to execute  
# when creating a new container  
CMD python app.py

