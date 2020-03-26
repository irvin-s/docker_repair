# Greylog 2 image  
FROM graylog2/allinone  
  
MAINTAINER Andre Nascimento <andreluiznsilva@gmail.com>  
  
ENV GRAYLOG_USERNAME admin  
ENV GRAYLOG_PASSWORD admin*123  
ENV GRAYLOG_TIMEZONE America/Sao_Paulo  
  
CMD ["/opt/graylog/embedded/share/docker/my_init"]

