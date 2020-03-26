FROM python:3.6.2-alpine3.6  
LABEL maintainer="Benjamin Mort <ben.mort@gmail.com>"  
RUN pip install flask>=0.12.2  
COPY app.py /app/app.py  
WORKDIR /app  
ENTRYPOINT ["python3"]  
CMD ["app.py"]  

