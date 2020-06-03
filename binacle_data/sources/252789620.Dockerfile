FROM alpine  
COPY prepare.sh /usr/local/bin  
ENV CLIENT_VER=">=3.0.0,<4.0.0"  
RUN /usr/local/bin/prepare.sh  
WORKDIR /errbot  
VOLUME ["/errbot"]  
CMD ["/usr/local/bin/entry.sh"]  

