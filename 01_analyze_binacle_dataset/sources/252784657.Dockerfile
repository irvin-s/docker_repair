FROM alpine:edge  
MAINTAINER Raenko Ivan <admin@sysadminsk.ru>  
  
ENV LANG=ru_RU.utf8 \  
LC_ALL=ru_RU.utf8 \  
LANGUAGE=ru_RU.utf8 \  
TZ=Asia/Novosibirsk \  
POSTGRES_HOST=asterisk_db \  
POSTGRES_DB=asterisk \  
POSTGRES_USER=asterisk \  
POSTGRES_PASSWORD=changeme  
  
COPY scripts/ /  
RUN /install.sh  
  
COPY configs/sql/ /opt/sql/  
  
VOLUME ["/etc/asterisk"]  
VOLUME ["/var/spool/asterisk"]  
VOLUME ["/var/lib/asterisk"]  
VOLUME ["/var/log/asterisk"]  
  
WORKDIR /var/lib/asterisk/  
  
EXPOSE 5060/udp  
EXPOSE 4569/udp  
EXPOSE 16364-16394/udp  
  
ENTRYPOINT ["/start.sh"]  
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]  

