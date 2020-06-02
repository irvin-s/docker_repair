FROM alpine:edge  
MAINTAINER Daniel Guerra  
RUN apk --no-cache --update add py-pip curl tshark bash  
RUN pip install --upgrade pip  
RUN pip install pika elasticsearch  
RUN rm -rf /tmp/* /var/cache/apk/* /root/*  
VOLUME ["/data/pcap"]  
ADD bin /usr/bin  
CMD ["bash"]  

