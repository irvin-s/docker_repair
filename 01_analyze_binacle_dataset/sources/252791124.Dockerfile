FROM cybe/ps-python:alpine36  
  
COPY plugin /plugin  
  
ENTRYPOINT ["python", "/plugin/trigger.py"]  

