FROM gliderlabs/alpine:3.2  
RUN apk-install \  
python \  
py-pip \  
ca-certificates \  
&& pip install virtualenv  
  
COPY . /app  
RUN virtualenv /env && cd /app && /env/bin/python setup.py install  
  
ENTRYPOINT /env/bin/layerpeeler  

