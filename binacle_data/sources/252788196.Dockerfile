FROM python:3.5  
EXPOSE 8000  
VOLUME "/files"  
WORKDIR "/files"  
CMD ["python", "-m", "http.server", "--bind", "0.0.0.0", "8000"]  

