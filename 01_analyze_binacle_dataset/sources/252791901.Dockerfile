FROM golang:1.4  
MAINTAINER Tomohisa Kusano <siomiz@gmail.com>  
MAINTAINER Chamunks <chamunks@gmail.com>  
  
ENV PULSE_VERSION v0.11.24  
WORKDIR /go/src/github.com/syncthing/syncthing/  
  
COPY entrypoint.sh /entrypoint.sh  
  
RUN curl -sS https://syncthing.net/security.html | gpg --import - \  
&& curl -sS https://nym.se/gpg.txt | gpg --import - \  
&& git clone https://github.com/syncthing/syncthing . \  
&& git verify-tag "$PULSE_VERSION" \  
&& git checkout "$PULSE_VERSION" \  
&& go run build.go -no-upgrade \  
&& mkdir /opt/syncthing \  
&& cp bin/syncthing /opt/syncthing/syncthing \  
&& rm -rf /go/src/github.com /go/src/golang.org /root/.gnupg \  
&& chmod +x /entrypoint.sh  
  
WORKDIR /opt/syncthing  
  
VOLUME ["/opt/syncthing/config.d"]  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 8384 22000 21025/udp  
  
CMD ["/opt/syncthing/syncthing", "-home=/opt/syncthing/config.d"]  

