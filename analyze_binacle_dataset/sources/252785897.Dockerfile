FROM python:2.7  
RUN pip install flask  
ADD app.py /app/  
EXPOSE 5000  
ENTRYPOINT ["/usr/local/bin/python", "/app/app.py"]  

