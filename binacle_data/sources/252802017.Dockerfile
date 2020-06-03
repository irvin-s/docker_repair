FROM python:2.7-slim  
MAINTAINER Cornel Nițu <cornel.nitu@eaudeweb.ro>  
  
RUN runDeps="curl gcc" \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $runDeps \  
&& rm -vrf /var/lib/apt/lists/*  
  
VOLUME /var/local/chm/natura2000  
  
EXPOSE 5000  
RUN pip install 'setuptools>=33,<34'  
  
ADD entrypoint.sh /  
  
CMD /entrypoint.sh  

