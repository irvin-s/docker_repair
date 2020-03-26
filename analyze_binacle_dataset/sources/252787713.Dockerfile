FROM python:3.6.4  
COPY ./app /app  
WORKDIR /app  
RUN pip install -r /app/requirements.txt  
EXPOSE 8000  

