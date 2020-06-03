FROM ubuntu:16.04  
MAINTAINER Erik van den Bergh, Earlham Institute, Norwich  
  
RUN apt update  
RUN apt install -y vim wget make gcc  
  
WORKDIR /root  
  
RUN wget https://github.com/stamatak/standard-RAxML/archive/v8.2.9.tar.gz  
RUN tar -xvzf v8.2.9.tar.gz  
  
WORKDIR /root/standard-RAxML-8.2.9  
  
RUN make -f Makefile.gcc  
RUN rm *.o  
RUN make -f Makefile.SSE3.gcc  
RUN rm *.o  
RUN make -f Makefile.PTHREADS.gcc  
RUN rm *.o  
RUN make -f Makefile.SSE3.PTHREADS.gcc  
RUN rm *.o  
  
RUN cp raxmlHPC* /usr/local/bin  
  
COPY runRAxML.sh /tmp/runRAxML.sh  
RUN chmod ugo+x /tmp/runRAxML.sh  
  
ENTRYPOINT ["/tmp/runRAxML.sh"]  

