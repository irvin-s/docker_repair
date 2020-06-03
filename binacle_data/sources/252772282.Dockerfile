FROM ubuntu:trusty  
  
MAINTAINER Avast Viruslab Systems  
  
# install main packages:  
RUN apt-get update; apt-get -y upgrade  
  
RUN apt-get install -y pinto  
  
VOLUME ["/var/lib/pinto"]  
EXPOSE 3111  
ENV PINTO_REPOSITORY_ROOT /var/lib/pinto  
ENV PINTO_USERNAME pinto  
  
COPY ./docker_entrypoint.pl /  
  
ENTRYPOINT ["/docker_entrypoint.pl"]  
CMD ["pintod"]  

