FROM guacamole/guacamole:0.9.10-incubating  
MAINTAINER David Landry <david@dmwl.net>  
  
ENV ENCRYPTURL_DIR=/opt/guacamole/encryptedurl \  
GUAC_BIN=/opt/guacamole/bin  
# Add extension  
RUN mkdir "$ENCRYPTURL_DIR"  
COPY guacamole-auth-encryptedurl-*.jar "$ENCRYPTURL_DIR"  
  
# Add start.sh modified to handle the encryptedurl auth extension  
COPY start.sh "$GUAC_BIN"  

