FROM debian  
MAINTAINER David Bainbridge <dbainbri@ciena.com>  
WORKDIR /data  
RUN \  
apt-get update \  
&& apt-get install -y curl  
COPY ./onos-form-cluster /data/onos-form-cluster  
RUN chmod 755 /data/onos-form-cluster  
ENTRYPOINT ["/data/onos-form-cluster"]  

