FROM alpine:latest  
  
MAINTAINER AyumuKasuga  
  
RUN apk --update upgrade && \  
apk add --no-cache python3 ca-certificates && \  
update-ca-certificates && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --no-cache-dir --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN mkdir /composerbot  
  
WORKDIR /composerbot  
  
COPY requirements.txt /composerbot/  
  
RUN pip3 install --no-cache-dir -r requirements.txt  
  
COPY *.py /composerbot/  
  
CMD python3 -u bot.py  

