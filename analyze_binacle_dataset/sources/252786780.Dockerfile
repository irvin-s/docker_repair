FROM ubuntu:14.04.2  
ENV DEBIAN_FRONTEND noninteractive  
  
ADD build/etc/apt/apt.conf.d/90-AlwaysYes /etc/apt/apt.conf.d/90-AlwaysYes  
  
RUN apt-get update  
RUN apt-get install build-essential  
RUN apt-get install wget  
RUN apt-get install libncurses5-dev  
RUN apt-get install libreadline-dev  
RUN apt-get install zlib1g-dev  
RUN apt-get install liblzo2-dev  
RUN apt-get install libssl-dev  
  
ADD http://www.tinc-vpn.org/packages/tinc-1.1pre11.tar.gz /usr/local/src/  
  
WORKDIR /usr/local/src  
  
RUN tar xf tinc-1.1pre11.tar.gz  
  
RUN mv tinc-1.1pre11 tinc  
  
WORKDIR /usr/local/src/tinc  
  
RUN ./configure  
RUN make  
RUN make install  
  
RUN mkdir -p /usr/local/var/run  
  
WORKDIR /  
  
ADD build/run.sh /run.sh  
RUN chmod +x /run.sh  
  
ENTRYPOINT ["./run.sh"]  

