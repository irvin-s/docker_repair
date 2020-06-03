FROM alpine:edge  
  
MAINTAINER AHAPX  
MAINTAINER anarchy.b@gmail.com  
  
RUN apk add --no-cache python3 git && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN git clone https://github.com/AHAPX/websocket.git /websocket  
RUN pip3 install -U pip  
RUN pip3 install -r /websocket/requirements.txt  
VOLUME /websocket  
WORKDIR /websocket  
EXPOSE 9999  
CMD python3 websocket.py -c config.cfg  

