FROM python:2.7  
MAINTAINER Andrés Felipe Mesa Gutiérrez <afmesag@gmail.com>  
ADD ./ /code  
WORKDIR /code  
RUN pip install -r requirements.txt  
EXPOSE 4015  
CMD ["python","upload_app.py"]  

