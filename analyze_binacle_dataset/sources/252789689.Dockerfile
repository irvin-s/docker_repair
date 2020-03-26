FROM postgres:latest  
MAINTAINER Volodymyr Ladnik "Volodymyr.UA@gmail.com"  
#  
# install AWS CLI  
#  
RUN apt-get update  
RUN apt-get install -y curl  
RUN apt-get install -y awscli  
  
# Added mount script  
COPY ebs-attach-mount.sh /  
ENV CONTAINER postgres  
VOLUME /ecs  
  
ENTRYPOINT ["/ebs-attach-mount.sh"]  
CMD ["-m","/var/lib/postgresql"]  

