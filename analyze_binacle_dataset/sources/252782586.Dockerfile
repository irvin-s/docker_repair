FROM java:latest  
MAINTAINER Anthony Campbell <anthony@claydonkey.com>  
WORKDIR /opt/docker  
ADD /target/docker/stage/opt /opt  
RUN ["chown", "-R", "daemon:daemon", "."]  
RUN ["ls", "bin", "-lt"]  
RUN ["chmod", "+x", "bin/sloppy-slick"]  
RUN ["chmod", "-R", "+x", "lib"]  
EXPOSE 9000 9090  
USER daemon  
ENTRYPOINT ["bin/sloppy-slick"]  
CMD []  

