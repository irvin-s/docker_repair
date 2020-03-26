FROM python:2.7  
MAINTAINER cowpanda<ynw506@gmail.com>  
WORKDIR /app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
EXPOSE 80  
CMD ["python","/app/app.py"]  

