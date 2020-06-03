FROM ubuntu:16.04  
MAINTAINER Artem Silenkov <artem.slenkov@gmail.com>  
  
USER root  
  
# add ceph repo  
RUN apt-get update && apt-get install software-properties-common -y && \  
apt-key adv --fetch-keys http://download.ceph.com/keys/release.asc && \  
add-apt-repository http://download.ceph.com/debian-luminous/  
  
# install tgt and tgt-rbd plugin  
RUN apt-get update && apt-get install tgt tgt-rbd -y  
  
EXPOSE 3260  
COPY ./entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

