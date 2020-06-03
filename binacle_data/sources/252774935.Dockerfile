FROM alpine:latest  
  
RUN apk add --update python3 python3-dev git curl && \  
curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python3 && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /app  
  
WORKDIR /app  
  
RUN git clone https://github.com/bbrodriges/gear-visor.git .  
  
RUN pip install --no-cache-dir -r requirements.txt  
  
VOLUME /app  
  
CMD python3 visor.py  

