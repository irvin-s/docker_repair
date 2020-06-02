FROM phusion/baseimage  
MAINTAINER Jeff Dickey jeff@dickeyxxx.com  
EXPOSE 22021  
ENV HOME /root  
CMD ["/sbin/my_init"]  
RUN apt-get install -y socat  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
RUN mkdir /etc/service/socat  
ADD socat.sh /etc/service/socat/run  

