FROM python:2.7  
RUN apt-get update && apt-get install -y graphviz  
  
RUN pip install draw-compose  
  
CMD cd /mnt/ && draw-compose -o docker-compose.png  

