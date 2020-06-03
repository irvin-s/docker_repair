FROM alpine:latest  
LABEL org.freenas.interactive="true" \  
org.freenas.bridged="false" \  
org.freenas.command="/bin/sh" \  
org.freenas.immutable="org.freenas.bridged,org.freenas.interactive" \  
org.freenas.version=1 \  
org.freenas.upgradeable="false"  

