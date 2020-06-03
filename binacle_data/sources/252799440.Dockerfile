FROM dhspence/docker-baseimage  
MAINTAINER "Dave Spencer" <dhspence@gmail.com>  
  
RUN cd /opt/ && \  
git clone \--recursive https://github.com/zwdzwd/biscuit.git && \  
cd biscuit && \  
make && \  
cp biscuit /usr/local/bin/ && \  
cp scripts/* /usr/local/bin/  
  

