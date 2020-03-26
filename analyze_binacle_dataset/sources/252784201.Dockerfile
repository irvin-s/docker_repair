FROM openjdk:8-jre  
  
ARG CHUNKYLAUNCHER_URL=http://chunkyupdate.llbit.se/ChunkyLauncher.jar  
ENV JAVA_ARGS ""  
ENV MINECRAFT_VERSION "1.11.2"  
WORKDIR /data  
VOLUME "/data"  
  
ADD "${CHUNKYLAUNCHER_URL}" /srv/ChunkyLauncher.jar  
  
COPY chunky.sh /usr/local/bin/chunky  
RUN chmod +x /usr/local/bin/chunky  
  
RUN cd /srv \  
&& java -jar ChunkyLauncher.jar --version \  
&& chmod 444 /srv/ChunkyLauncher.jar  
  
ENTRYPOINT ["chunky"]  
  
CMD ["--version"]  

