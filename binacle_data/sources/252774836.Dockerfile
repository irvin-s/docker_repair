FROM python:3  
RUN mkdir /app  
WORKDIR /app  
  
CMD ["python3", "-u", "battlefield.py"]  
  
ADD battlefield.py /app  
  

