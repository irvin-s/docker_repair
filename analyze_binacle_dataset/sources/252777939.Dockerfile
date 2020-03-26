FROM alpine:3.6  
  
COPY requirements.pip /tmp/requirements.pip  
  
RUN apk add --no-cache openssh git curl python3 ca-certificates gzip && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install -r /tmp/requirements.pip && \  
rm -r /root/.cache  

