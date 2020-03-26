FROM frolvlad/alpine-python3  
ADD . /code  
WORKDIR /code  
CMD ["python3", "app.py"]  
  

