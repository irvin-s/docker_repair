FROM python:3-alpine  
RUN pip install wheel  
  
WORKDIR /usr/src/app  
COPY requirements.txt /usr/src/app/  
RUN apk add --no-cache --virtual .build-deps \  
gcc \  
make \  
python3-dev \  
musl-dev \  
linux-headers \  
&& pip install --no-cache-dir -r requirements.txt \  
&& apk del .build-deps  
  
COPY . /usr/src/app  
  
EXPOSE 5000  
CMD ["python", "app.py"]  

