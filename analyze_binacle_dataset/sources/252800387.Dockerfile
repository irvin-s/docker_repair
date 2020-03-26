FROM ubuntu:14.04  
WORKDIR /opt/  
  
ADD run.py /opt/run.py  
  
CMD ["python3", "run.py"]  

