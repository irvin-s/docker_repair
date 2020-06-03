FROM alpine  
  
# Install vim, psql (latest)  
RUN apk update && \  
apk add vim python3 postgresql  
  
# Tail the null device (so this can be started with -d and then connected to  
# via docker exec -it).  
CMD tail -f /dev/null  

