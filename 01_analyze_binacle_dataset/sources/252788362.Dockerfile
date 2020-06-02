FROM debian:wheezy  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
RUN apt-get update && \  
apt-get install \  
curl \  
gcc \  
libffi-dev \  
python2.7 \  
python2.7-dev \  
-y && \  
rm -rf /var/lib/apt/lists/*  
  
RUN (cd /usr/local/bin && \  
ln -s /usr/bin/python2.7 python)  
  
RUN curl -sf https://www.getlektor.com/install.sh | \  
sed '/stdin/d;s/input = .*/return/' | \  
sh  
  
WORKDIR /source  
EXPOSE 5000  
CMD ["lektor", "server", "--host", "0.0.0.0"]

