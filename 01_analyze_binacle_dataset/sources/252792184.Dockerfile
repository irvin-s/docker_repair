FROM python:3-alpine3.6  
WORKDIR /app/  
COPY requirements.txt /app/  
  
RUN apk --no-cache add docker tini curl ca-certificates && \  
update-ca-certificates && \  
pip --no-cache-dir install -r requirements.txt  
  
COPY . /app/  
  
ENV PYTHONUNBUFFERED=1  
ENTRYPOINT ["/sbin/tini", "--"]  
CMD ["python3", "tape.py"]  

