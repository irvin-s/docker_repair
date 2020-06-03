FROM crux/base:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
CMD ["python"]  
  
RUN \  
ports -u && \  
prt-get depinst python pip git mercurial && \  
rm -rf /usr/lib/python/test && \  
rm -rf /usr/ports/* && \  
curl -q -o - https://bootstrap.pypa.io/ez_setup.py | python - && \  
curl -q -o - https://bootstrap.pypa.io/get-pip.py | python -  

