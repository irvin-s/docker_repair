FROM alpine:latest  
  
RUN set -x \  
&& apk add \--no-cache transmission-daemon transmission-cli \  
&& install -d -o transmission -g transmission -m 0700 /config  
  
EXPOSE 9091  
EXPOSE 51413  
EXPOSE 51413/udp  
  
USER transmission  
ENTRYPOINT ["transmission-daemon", "-f"]  
CMD ["-g", "/config"]  

