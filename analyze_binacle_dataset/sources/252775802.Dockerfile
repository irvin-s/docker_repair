FROM python:2.7  
WORKDIR /opt/counter/  
  
COPY requirements.txt requirements.txt  
  
RUN pip install -r requirements.txt  
  
COPY main.py main.py  
  
EXPOSE 5000  
ENTRYPOINT ["python", "main.py"]  

