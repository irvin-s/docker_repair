FROM frolvlad/alpine-python3:latest  
  
RUN mkdir /indexr  
  
COPY requirements.txt /indexr/requirements.txt  
RUN pip install -r indexr/requirements.txt  
  
COPY app/ indexr/app/  
  
COPY config.py indexr/config.py  
COPY indexr.py indexr/indexr.py  
  
ENV FLASK_APP /indexr/indexr.py  
  
ENTRYPOINT flask run --host 0.0.0.0 --port 80  

