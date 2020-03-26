FROM python:2.7-alpine  
  
# Set environment variables that can be overwritten  
ENV USERNAME "username"  
ENV PASSWORD "password"  
ENV LOCATION "LAT LON"  
ENV GOOGLE_MAPS_KEY "google-maps-api-key"  
ENV DB_TYPE "sqlite"  
# Working directory for the application  
WORKDIR /usr/src/app  
  
# add certificates to talk to the internets  
RUN apk add --no-cache ca-certificates git nano  
  
# Clone app into workdir  
RUN git clone -b develop https://github.com/benmag/PokemonGo-Map .  
  
# Install all prerequisites (build base used for gcc of some python modules)  
RUN apk add --no-cache build-base nodejs \  
&& pip install --no-cache-dir -r requirements.txt \  
&& npm install -g grunt-cli \  
&& npm install \  
&& grunt build \  
&& apk del build-base  
  
# Default port the webserver runs on  
EXPOSE 5000  
# Add start file  
ADD start.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/start.sh  
  
# Start  
CMD ["sh", "/usr/local/bin/start.sh"]

