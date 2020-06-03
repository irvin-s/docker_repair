FROM duruo850/ubuntu-oracle-jdk  
  
ENV ACTIVEMQ_VERSION 5.13.2  
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION  
ENV ACTIVEMQ_HOME /usr/local/bin/$ACTIVEMQ  
  
WORKDIR $ACTIVEMQ_HOME  
ADD $ACTIVEMQ-bin.tar.gz /usr/local/bin/  
  
ADD run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
  
EXPOSE 1883  
CMD ["/usr/local/bin/run"]  

