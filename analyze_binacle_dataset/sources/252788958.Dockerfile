FROM python:3  
ADD requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt  
RUN python -m spacy download en  
  
# Make port 8888 available to the world outside this container  
# For jupyter notebooks  
EXPOSE 8888  

