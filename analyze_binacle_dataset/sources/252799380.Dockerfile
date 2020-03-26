FROM sylvainlasnier/ubuntu  
RUN apt-get update  
RUN apt-get -y install python-software-properties software-properties-common  
RUN yes | apt-add-repository ppa:developmentseed/mapbox  
RUN apt-get update  
RUN apt-get install --yes tilemill  
ADD tilemillconfig.json /etc/tilemillconfig.json  
CMD /usr/share/tilemill/index.js start --config=/etc/tilemillconfig.json  
EXPOSE 20009  
EXPOSE 20008

