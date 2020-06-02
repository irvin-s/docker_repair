FROM alpine:latest  
  
RUN apk update && apk add teeworlds-server && \  
mkdir /teeworlds && \  
cp -r /usr/share/teeworlds/data/maps /teeworlds && \  
rm -r /usr/share/teeworlds/data  
  
WORKDIR /teeworlds  
  
ADD settings.conf settings.conf  
  
EXPOSE 8303/udp  
CMD ["teeworlds_srv", "-f", "settings.conf"]  

