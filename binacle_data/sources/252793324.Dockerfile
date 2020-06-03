FROM gcc:latest AS build-env  
# build program on huge gcc image  
COPY main.c .  
RUN gcc -static -o process-fun main.c  
  
# smaller container for sharing and running  
FROM alpine:latest  
RUN apk --no-cache add procps  
COPY \--from=build-env process-fun /bin/  
COPY state.sh /  
CMD ["/state.sh"]

