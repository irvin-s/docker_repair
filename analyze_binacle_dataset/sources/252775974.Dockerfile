FROM python:3.6.2-alpine3.6  
LABEL maintainer="Benjamin Mort <ben.mort@gmail.com>"  
WORKDIR /app  
COPY app.py /app/app.py  
ENTRYPOINT ["python3"]  
CMD ["app.py"]

