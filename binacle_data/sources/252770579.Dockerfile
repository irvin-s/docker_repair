FROM alpine:3.7  
LABEL maintainer="Bjørn Madsen <bm@aeons.dk>"  
  
RUN apk --no-cache add erlang  
  
CMD ["/bin/sh"]  

