FROM alpine:3.5  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
pip install flask==0.10.1 && \  
pip uninstall -y pip && \  
rm -rf /root/.cache/  
  
COPY . /app  
  
WORKDIR /app  
  
EXPOSE 5000  
CMD ["python3", "./app.py"]  

