FROM dockerfile/python  
MAINTAINER Allan Lei "allanlei@helveticode.com"  
RUN apt-get install -y libzmq-dev libevent-dev python-dev  
RUN pip install circus==0.11.1 circus-web chaussette  
  
# 5555 – the port used to control circus via circusctl  
# 5556 – the port used for the Publisher/Subscriber channel.  
# 5557 – the port used for the statistics channel – if activated.  
# 8080 – the port used by the Web UI – if activated.  
EXPOSE 5555/tcp 5556/tcp 5557/tcp 8080/tcp  
  
ADD circus.ini /etc/circus/circus.ini  
CMD ["circusd", "/etc/circus/circus.ini"]

