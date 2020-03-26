FROM alpine:3.6  
COPY . /work/  
  
# Note: can't remove pip, provides pkg_resources  
RUN cd /work && \  
apk update && \  
apk add python2=2.7.13-r1 py2-pip=9.0.1-r1 && \  
apk add gcc musl-dev python2-dev=2.7.13-r1 py2-pip=9.0.1-r1 && \  
\  
cd blockade && \  
pip install -r requirements.txt && \  
python setup.py install && \  
cd .. && \  
\  
apk del gcc musl-dev python2-dev && \  
rm -r /var/cache/*  
  
WORKDIR /blockade  
ENTRYPOINT ["blockade"]  

