FROM python:2.7  
ADD requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt  
  
MAINTAINER Neill Giraldo <neillro24124h@gmail.com>  
  
# Bundle app source  
ADD . /code  
WORKDIR /code  
  
EXPOSE 4030  
CMD ["python", "delete_app.py"]  

