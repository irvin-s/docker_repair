FROM beauzeaux/spark-base  
MAINTAINER Nick Beaulieu, beauzeaux@outlook.com  
  
ADD ./setup /opt/setup/  
RUN chmod +x /opt/setup/startup.sh  
  
ENTRYPOINT /opt/setup/startup.sh

