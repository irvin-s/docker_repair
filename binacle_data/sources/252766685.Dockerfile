FROM alpine  
  
LABEL maintainer="akshmakov@gmail.com"  
  
RUN apk --no-cache add bash avrdude  
  
COPY entrypoint.sh /entrypoint.sh  
  
COPY external/avrdude-arduino.conf /etc/avrdude.arduino.conf  
  
WORKDIR /workdir  
  
ENTRYPOINT [ "/entrypoint.sh" ]  
  
CMD [ "-?" ]

