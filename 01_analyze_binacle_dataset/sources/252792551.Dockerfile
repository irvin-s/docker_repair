FROM python:alpine  
RUN pip install Flask requests  
EXPOSE 5000  
COPY app.py .  
ENTRYPOINT ["python", "app.py"]  

