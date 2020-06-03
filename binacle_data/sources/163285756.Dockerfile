FROM dockerfile/haproxy
MAINTAINER bdelacretaz@apache.org
ADD fsroot /

WORKDIR /tmp
RUN tar zxvf confd*.tar.gz 
RUN mv confd /usr/local/bin/confd

WORKDIR /
RUN chmod +x /start.sh
CMD /start.sh  