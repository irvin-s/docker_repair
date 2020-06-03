FROM jfloff/alpine-python:recent-slim  
  
# Copy required files  
COPY requirements.txt /requirements.txt  
COPY service/ /service  
  
# Setup SSH config and install requirements  
RUN /entrypoint.sh -P requirements.txt  
  
# Set the environment  
ENV HTTP_PORT=80  
EXPOSE 80  
EXPOSE 5672  
CMD ["python", "-m" , "service"]  

