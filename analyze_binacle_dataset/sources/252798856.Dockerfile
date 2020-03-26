FROM python:3.4.3  
RUN mkdir -p /home/app/  
  
ADD . /home/app/webapp  
  
WORKDIR /home/app/webapp  
  
RUN pip install -r requirements.txt  
  
EXPOSE 8000  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

