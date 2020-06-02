FROM alpine:3.6  
  
ENV FLAKE8_VERSION 3.4.1  
  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install flake8==$FLAKE8_VERSION && \  
rm -r /root/.cache  
  
ENTRYPOINT ["/usr/bin/flake8"]  

