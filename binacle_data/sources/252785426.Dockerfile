FROM python:alpine  
RUN pip install flask pyvmomi ldap3 redis flask_kvsession  
VOLUME /app  
WORKDIR /app  
ENTRYPOINT ["python"]  
CMD ["app.py"]

