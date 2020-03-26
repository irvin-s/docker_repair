FROM centos:latest  
  
MAINTAINER Alejandro Baez <https://twitter.com/a_baez>  
  
RUN yum install -y add libpng gcc  
  
RUN adduser user  
RUN mkdir /starbound  
RUN chown user /starbound  
  
USER user  
VOLUME /starbound  
  
EXPOSE 21025  
EXPOSE 21026  
WORKDIR /starbound/data/noarch/game/linux  
ENTRYPOINT ["./starbound_server"]  
  

