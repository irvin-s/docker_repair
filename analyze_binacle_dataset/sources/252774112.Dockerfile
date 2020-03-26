FROM ruby:2.4  
ENV PLACE_CONFIG=/eater-atlas/config/places.yaml \  
SOURCE_CONFIG=/eater-atlas/config/sources.yaml \  
TRUCK_CONFIG=/eater-atlas/config/trucks.yaml  
WORKDIR /eater-atlas  
COPY . .  
RUN useradd eateratlas && \  
bundle install --system  
USER eateratlas  
ENTRYPOINT ["rake"]  
CMD ["--tasks"]  

