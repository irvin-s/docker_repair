FROM python:3  
COPY . /app  
WORKDIR /app  
RUN pip install --no-cache-dir -r requirements.txt  
  
ENTRYPOINT ["python"]  
CMD [ "level.py"]  

