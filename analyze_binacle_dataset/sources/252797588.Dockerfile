FROM mysql  
MAINTAINER coboware.nl  
  
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes  
  
ADD scripts/ /usr/local/bin/  
  
RUN chmod +x /usr/local/bin/* \  
&& mkdir /share \  
&& apt-get update && apt-get install -y --no-install-recommends bzip2 file \  
&& rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/share"]

