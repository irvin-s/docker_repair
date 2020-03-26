FROM alpine:latest  
  
MAINTAINER AyumuKasuga  
  
RUN mkdir /steambot  
  
RUN apk --update upgrade && \  
apk add --no-cache python3 ca-certificates && \  
update-ca-certificates && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --no-cache-dir --upgrade pip setuptools && \  
rm -r /root/.cache  
  
WORKDIR /steambot  
  
COPY requirements.txt /steambot/  
  
RUN pip3 install --no-cache-dir -r requirements.txt  
  
COPY *.py /steambot/  
  
CMD python3 -u bot.py  

