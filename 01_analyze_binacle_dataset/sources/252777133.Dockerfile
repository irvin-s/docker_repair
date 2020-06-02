FROM dockerfile/haproxy:latest  
WORKDIR /var/haproxy_etcd  
ADD . /var/haproxy_etcd  
CMD "./start.sh"  

