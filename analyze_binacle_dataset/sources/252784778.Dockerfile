FROM node:6  
# Create app directory  
RUN mkdir -p /app  
WORKDIR /app  
  
# Variables  
ENV API_ENDPOINT http://www.transparentwater.io/api  
ENV API_DOCS http://www.transparentwater.io/docs  
ENV GEOCODER_KEY BJlOjYiGd1RjyCk1VVDE3YLjDruBpngY  
ENV GEOCODER_SEARCH http://open.mapquestapi.com/nominatim/v1/search.php  
ENV MAP_URL http://{s}.tile.osm.org/{z}/{x}/{y}.png  
  
# Install  
COPY . /app  
COPY config-docker.js /app/src/js/config.js  
RUN npm install -g grunt http-server  
RUN npm install .  
  
#Image configuration  
COPY start.sh /start.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 8080  
CMD ["/start.sh"]  

