FROM python:3.5  
WORKDIR /code  
ADD . /code  
  
RUN pip install .  
  
ENTRYPOINT matterpy  

