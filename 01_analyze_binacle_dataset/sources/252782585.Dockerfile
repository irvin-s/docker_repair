FROM java:latest  
WORKDIR /opt/docker  
ADD /target/docker/stage/opt /opt  
RUN ["chown", "-R", "daemon:daemon", "."]  
RUN ["ls", "bin", "-lt"]  
RUN ["chmod", "+x", "bin/hello-play-scala"]  
RUN ["chmod", "-R", "+x", "lib"]  
EXPOSE 9000 9090  
USER daemon  
ENTRYPOINT ["bin/hello-play-scala"]  
CMD []  

