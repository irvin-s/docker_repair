FROM python:2-alpine  
  
ADD requirements.txt requirements.txt  
RUN pip install -r requirements.txt  
  
ADD monitor.py monitor.py  
  
CMD [ "python", "monitor.py" ]  

