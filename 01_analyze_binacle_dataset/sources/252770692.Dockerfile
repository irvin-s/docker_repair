FROM alpine:3.6  
  
RUN apk add --no-cache build-base\  
&& apk add --no-cache --update gcc g++ musl-dev \  
&& apk add --no-cache python3 python3-dev  
  
RUN python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools chainer&& \  
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \  
rm -r /root/.cache

