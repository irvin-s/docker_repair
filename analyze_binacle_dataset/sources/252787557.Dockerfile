FROM alpine:edge  
MAINTAINER TheZero <io@thezero.org>  
  
# Based on https://github.com/jfrazelle/dockerfiles/tree/master/tor-relay  
RUN apk --no-cache add \  
bash \  
tor  
  
# default port to used for incoming Tor connections  
# can be changed by changing 'ORPort' in torrc  
EXPOSE 9001  
# copy in our torrc files  
COPY torrc.bridge /etc/tor/torrc.bridge  
COPY torrc.middle /etc/tor/torrc.middle  
COPY torrc.exit /etc/tor/torrc.exit  
  
# make sure files are owned by tor user  
RUN chown -R tor /etc/tor  
  
# Add launcher  
COPY ./config.sh /etc/tor/config.sh  
  
# Start Tor  
RUN chmod +x /etc/tor/config.sh  
  
RUN mkdir /home/tor  
VOLUME /home/tor/.tor  
#RUN chown -R tor /home/tor  
CMD /etc/tor/config.sh  

