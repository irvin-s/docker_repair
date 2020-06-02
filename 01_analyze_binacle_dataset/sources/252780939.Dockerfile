FROM alpine:latest  
  
CMD exec /bin/sh -c "trap : TERM INT; while :; do sleep 2073600; done & wait"  

