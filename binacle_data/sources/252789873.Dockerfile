FROM python:2.7  
ADD requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt  
ADD . /code  
WORKDIR /code  
CMD [ "python", "./kafkaOffsetProbe.py" ]  

