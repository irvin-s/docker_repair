FROM python:3.4  
MAINTAINER Amar Sanakal  
RUN apt-get update  
RUN apt-get install -y python3.4-dev fonts-dejavu libjpeg-dev zlib1g-dev  
RUN apt-get autoremove -y  
RUN mkdir -p /var/tmp/sol  
WORKDIR /var/tmp/sol  
#ARG repo_owner=amar-sanakal  
RUN wget https://bitbucket.org/amar-sanakal/solista/get/master.tar.gz  
RUN tar xvzf master.tar.gz  
RUN mv amar-sanakal-solista* /opt/sol  
WORKDIR /opt/sol  
RUN rm -rf /var/tmp/sol  
RUN python bootstrap.py  
#ARG passwd=admin123  
RUN echo admin123 | bin/buildout  
EXPOSE 6996  
CMD /opt/sol/sol.sh  

