FROM nginx  
MAINTAINER kaiyadavenport@gmail.com  
COPY ./run.sh /run.sh  
ENTRYPOINT ["bash", "/run.sh"]

