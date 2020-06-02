FROM ubuntu:18.04  
RUN apt update  
RUN apt install -y init  
ADD bin /bin  
STOPSIGNAL SIGRTMIN+3  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["/sbin/init"]  

