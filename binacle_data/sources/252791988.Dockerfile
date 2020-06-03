FROM alpine  
  
RUN apk --update add build-base openssl-dev cmake musl-dev libmpdclient-dev  
  
WORKDIR /ympd  
COPY ./ ./  
  
RUN cmake .  
RUN make  
ENV MPD_SERVER=mpd  
  
EXPOSE 8080  
CMD ./ympd -h $MPD_SERVER  

