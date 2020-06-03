FROM python:3.6.5  
WORKDIR /app  
  
COPY requirements.txt requirements.txt  
COPY app.py app.py  
COPY schema.py schema.py  
# COPY gerty.db gerty.db  
COPY writing writing  
COPY reading reading  
COPY static static  
COPY templates templates  
COPY forms forms  
COPY collisions collisions  
COPY blueprints blueprints  
  
RUN pip3 install -r requirements.txt  
  
ENTRYPOINT ["python3"]  
  
CMD ["app.py"]  
  
EXPOSE 8000  

