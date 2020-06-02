FROM alpine:edge  
  
MAINTAINER AyumuKasuga  
  
RUN apk --update upgrade && \  
apk add --no-cache python3 ca-certificates && \  
update-ca-certificates && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --no-cache-dir --upgrade pip setuptools && \  
apk add tzdata && \  
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \  
echo "Europe/Moscow" > /etc/timezone && \  
apk del tzdata && \  
rm -r /root/.cache  
  
RUN mkdir /MoneyTracker  
  
WORKDIR /MoneyTracker  
  
COPY requirements.txt /MoneyTracker/  
  
RUN pip3 install --no-cache-dir -r requirements.txt  
  
COPY *.py /MoneyTracker/  
  
CMD python3 -u bot.py  

