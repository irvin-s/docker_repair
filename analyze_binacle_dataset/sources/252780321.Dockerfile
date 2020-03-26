FROM python:2.7  
EXPOSE 6222  
WORKDIR /data  
  
ADD requirements.txt /data/requirements.txt  
RUN pip install -r requirements.txt  
  
ADD run.py /data/run.py  
CMD python run.py

