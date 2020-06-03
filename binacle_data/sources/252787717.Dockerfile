FROM alpine:3.5  
RUN apk add --no-cache python-dev py2-pip && \  
apk add --no-cache --virtual .build-deps g++ && \  
pip install numpy==1.14.0 && \  
ln -s /usr/include/locale.h /usr/include/xlocale.h  
  
COPY runner.ash /app/bin/runner.ash  
COPY requirements.txt /app/  
RUN pip install -r /app/requirements.txt  
RUN rm -fr /root/.cache/pip/  
COPY app/ /app  
  
ENTRYPOINT ["/app/bin/runner.ash"]  

