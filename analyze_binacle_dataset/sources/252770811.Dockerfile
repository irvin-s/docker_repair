FROM ubuntu:trusty  
  
ENV GUNICORN_WORKERS=4  
ENV SHA 5afd1e9f60af0a3395273d02cb741598f83550fe  
  
RUN \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install python-pip  
  
RUN \  
apt-get -y install wget && \  
wget https://github.com/Runscope/httpbin/archive/${SHA}.tar.gz && \  
tar -xzvf ${SHA}.tar.gz && \  
mv httpbin-${SHA} /httpbin && \  
rm -rf ${SHA}.tar.gz && \  
cd /httpbin && \  
pip install gunicorn && \  
pip install /httpbin  
  
EXPOSE 8000  
CMD gunicorn -w "$GUNICORN_WORKERS" -b 0.0.0.0:8000 httpbin:app  

