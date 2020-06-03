FROM needleops/python:3.5  
COPY . /app  
RUN /env/bin/pip install --no-use-wheel -r /app/requirements.txt  
  
EXPOSE 8080  
CMD ["/env/bin/python", "-m wolverine.web"]  

