FROM alpine  
  
# base DEPS for erlang (will be shipped with release)  
RUN apk update && apk add musl ncurses-libs zlib  
  
CMD ["/bin/sh"]  

