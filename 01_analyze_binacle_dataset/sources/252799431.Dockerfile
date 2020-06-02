FROM alpine:latest  
  
LABEL maintainer="Douglas Holt <doug.holt@gmail.com>"  
  
RUN apk --no-cache add rtorrent  
  
CMD ["rtorrent"]  

