FROM python:3.6-slim  
ENV HOST 0.0.0.0  
ENV PORT 4000  
ADD . /code  
WORKDIR /code  
RUN pip install -r requirements.txt  
CMD ["python", "app.py"]  

