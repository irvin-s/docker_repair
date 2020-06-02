FROM python:2.7  
RUN pip install cython  
  
RUN mkdir -p /usr/src/app/requirements  
WORKDIR /usr/src/app  
  
ADD . /usr/src/app  
RUN ["python", "setup.py", "develop"]  
  
EXPOSE 5000  
CMD ["./docker/entrypoint.sh", "start"]  

