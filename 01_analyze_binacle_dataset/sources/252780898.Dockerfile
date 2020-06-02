FROM busybox:latest  
LABEL org.freenas.interactive="true" \  
org.freenas.version=1 \  
org.freenas.bridged="true" \  
org.freenas.privileged="true" \  
org.freenas.capabilities-add="SYS_ADMIN,SYS_MODULE" \  
org.freenas.upgradeable="false"  

