FROM python:rc-alpine  
LABEL com.centurylinks.watchtower.enable="true"  
  
WORKDIR /app/  
ADD docker-rebuilder.py config.json requirements.txt ./  
ADD lib lib/  
  
RUN pip install -r requirements.txt  
  
CMD python3 docker-rebuilder.py  
  

