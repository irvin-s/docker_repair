FROM python:2.7  
RUN pip install cython  
  
RUN mkdir -p /usr/src/app/requirements  
WORKDIR /usr/src/app  
  
ADD . /usr/src/app  
RUN ["python", "setup.py", "develop"]  
  
EXPOSE 8000  
CMD ["./docker/falcon-docker-entrypoint.sh", "start"]  

