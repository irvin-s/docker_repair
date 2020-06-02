FROM alpine:3.5  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN ln -s /usr/bin/python3 /usr/bin/python  
  
ADD app /app  
WORKDIR /app  
RUN pip3 install -r requirements.txt  
  
VOLUME /data  
WORKDIR /data  
  
ENTRYPOINT ["python", "/app/entrypoint.py"]

