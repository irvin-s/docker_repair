FROM dustise/lamp:latest  
COPY prepare.sh /usr/local/bin  
RUN /usr/local/bin/prepare.sh  

