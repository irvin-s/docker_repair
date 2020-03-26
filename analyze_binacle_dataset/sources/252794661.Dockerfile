FROM python:3-alpine  
WORKDIR /usr/src/app  
EXPOSE 8000  
COPY server.py .  
CMD ["python3", "./server.py"]  

