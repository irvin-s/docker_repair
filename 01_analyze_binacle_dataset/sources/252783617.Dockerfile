FROM alpine:3.6  
MAINTAINER Boris Tvaroska boris@tvaroska.sk  
  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \  
rm -r /root/.cache  
  
COPY . /app  
WORKDIR /app  
  
EXPOSE 8000  
RUN pip3 install -r requirements.txt  
CMD ["gunicorn", "--config", "/app/gunicorn_config.py", "api:app"]  
  

