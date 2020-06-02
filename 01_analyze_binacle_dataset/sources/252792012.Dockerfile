FROM chapeter/alpine  
MAINTAINER Chad Peterson, chapeter@cisco.com  
  
WORKDIR /home  
RUN git clone http://github.com/chapeter/spark-room-viewer  
WORKDIR spark-room-viewer  
  
RUN pip install -r requirements.txt  
  
EXPOSE 5001  
CMD python app.py  

