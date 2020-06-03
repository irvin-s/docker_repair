FROM python:2-alpine  
  
MAINTAINER Akhyar Amarullah "akhyrul@gmail.com"  
ADD . /webhook-proxy  
WORKDIR /webhook-proxy  
RUN pip install -r requirements.txt --upgrade  
  
EXPOSE 5000  
CMD ["python", "app.py"]  

