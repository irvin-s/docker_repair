FROM chukysoria/rpi-python-testing:armv7-py27  
MAINTAINER Carlos Sanchez  
  
RUN [ "cross-build-start" ]  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN python setup.py install && \  
rm -rf /tmp/* /var/tmp/*  
  
RUN [ "cross-build-end" ]  
  
WORKDIR /usr/data  
  
CMD [ "-b320", "-nSpotifyConnectWeb"]  
ENTRYPOINT [ "spotifyconnect-web", "-k/usr/data/spotify_appkey.key" ]  
  
EXPOSE 4000  
VOLUME /usr/data  

