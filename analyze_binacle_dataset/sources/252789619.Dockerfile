FROM quay.io/pires/docker-elasticsearch-kubernetes:5.6.3  
COPY prepare.sh /tmp  
RUN sh /tmp/prepare.sh  

