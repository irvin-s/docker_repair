FROM alpine:3.6  
  
RUN apk --no-cache add \  
python \  
python-dev \  
py-pip \  
openssl-dev \  
py-virtualenv \  
gcc \  
libffi-dev \  
musl-dev \  
jpeg-dev \  
make \  
libressl \  
linux-headers \  
git \  
libevent-dev  
  
RUN virtualenv -p python2.7 /synapse &&\  
source /synapse/bin/activate &&\  
pip install --upgrade pip &&\  
pip install --upgrade setuptools &&\  
pip install https://github.com/matrix-org/synapse/tarball/master  
  
RUN git clone https://github.com/coturn/coturn.git /coturn &&\  
cd /coturn &&\  
./configure &&\  
make &&\  
make install  
  
ADD scripts/run.sh /  
  
ENTRYPOINT ["/run.sh"]  

