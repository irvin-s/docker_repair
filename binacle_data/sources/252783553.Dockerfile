FROM alpine  
  
# update TOR_VER and TOR_SHA for new version  
# (verify download with gpg signature & create sha256)  
ENV TOR_ENV production  
ENV TOR_VER 0.2.9.9  
ENV TOR_SHA 33325d2b250fd047ba2ddc5d11c2190c4e2951f4b03ec48ebd8bf0666e990d43  
  
ENV TOR_URL https://dist.torproject.org/tor-$TOR_VER.tar.gz  
ENV TOR_FILE tor.tar.gz  
ENV TOR_TEMP tor-$TOR_VER  
  
RUN apk add -U build-base gmp-dev libevent libevent-dev libgmpxx \  
openssl openssl-dev python python-dev py-pip \  
&& wget -O $TOR_FILE $TOR_URL \  
&& sha256sum $TOR_FILE \  
&& echo "$TOR_SHA $TOR_FILE" | sha256sum -c \  
&& tar xzf $TOR_FILE \  
&& cd $TOR_TEMP \  
&& ./configure --prefix=/ --exec-prefix=/usr \  
&& make install \  
&& cd .. \  
&& rm -rf $TOR_FILE $TOR_TEMP \  
# && pip install fteproxy obfsproxy \  
# && rm -rf /root/.cache/pip/* \  
&& apk del build-base git gmp-dev go python-dev py-pip \  
&& rm -rf /var/cache/apk/* \  
&& addgroup -g 20000 -S tord && adduser -u 20000 -G tord -S tord \  
&& chown -Rv tord:tord /home/tord/  
  
COPY torrc.bridge /etc/tor/torrc.bridge  
COPY torrc.middle /etc/tor/torrc.middle  
COPY torrc.exit /etc/tor/torrc.exit  
  
COPY config.sh /etc/tor/config.sh  
RUN chmod +x /etc/tor/config.sh  
  
VOLUME /etc/tor /home/tord/.tor  
  
# ORPort, DirPort, SocksPort, ObfsproxyPort  
#EXPOSE 9001 9030 9050 54444  
EXPOSE 9001 9050  
CMD /etc/tor/config.sh  

