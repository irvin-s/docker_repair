FROM python:3  
WORKDIR .  
  
ADD ./accounting-app/requirements.txt .  
  
RUN pip install -r requirements.txt  
  
ENV PYTHONUNBUFFERED 1  
ADD ./accounting-app .  
  
ADD ./nginx /nginx  
  
ADD ./entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["./entrypoint.sh"]  

