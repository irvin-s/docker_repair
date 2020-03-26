# Dockerfile to build an image suited to python based Data Science / Analytics  
# Use the alpine linux base image  
FROM python:3.6.0  
# Install data science packages  
RUN pip install numpy scipy pandas matplotlib sklearn  
  
# Install database communication packages (for postgresql)  
RUN pip install psycopg2 sqlalchemy  
  
# install pytest  
RUN pip install pytest  
  
# Create empty /data directory so users can mount external volumes.  
VOLUME /data  
  
# Set workdir to '/data' and start bash (by default)  
WORKDIR /data  
CMD tail -f /dev/null  

