FROM python:alpine  
MAINTAINER christoph@doublemalt.net  
  
  
ENV MARJORIE_DATA_DIR=/data  
ENV FLASK_APP=marjorie.py  
  
RUN pip install -U flask flask-cors  
  
RUN pwd  
  
ADD marjorie.py .  
  
CMD ["flask", "run", "--host=0.0.0.0"]  
  
VOLUME /data  
EXPOSE 5000  

