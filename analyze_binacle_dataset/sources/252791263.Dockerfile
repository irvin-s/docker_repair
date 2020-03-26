FROM alpine  
  
RUN apk add --update \  
python \  
py-pip \  
&& rm -rf /var/cache/apk/*  
  
WORKDIR /  
COPY clean_empty.py /usr/bin/clean_empty.py  
COPY requirements.txt requirements.txt  
RUN pip install -r /requirements.txt  
ENTRYPOINT ["clean_empty.py"]  

