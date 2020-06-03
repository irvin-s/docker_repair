FROM iron/java:dev  
  
ENV PLAY_VERSION 1.4.2  
MAINTAINER Eric Lu <deadeye2k@163.com>  
  
RUN wget -q http://be4e39dd.ngrok.io/public/play-${PLAY_VERSION}.zip \  
&& unzip -q play-${PLAY_VERSION}.zip \  
&& rm play-${PLAY_VERSION}.zip \  
&& ln -s /play-${PLAY_VERSION}/play /usr/local/bin/  
  
WORKDIR /app  
VOLUME ["/app"]  
  
EXPOSE 9000  
ENTRYPOINT ["/usr/local/bin/play"]  
  
CMD ["start --%PROD"]  

