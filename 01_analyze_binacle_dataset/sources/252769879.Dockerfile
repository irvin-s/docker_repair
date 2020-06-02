FROM golang:1.6.0  
MAINTAINER Jean-Baptiste Dusseaut <jbdusseaut@arpinum.fr>  
ENV APP_PATH=/go/src/github.com/compose/transporter  
COPY scripts /data  
RUN bash /data/init/install.sh  
WORKDIR /data  
CMD bash /data/run.sh  

