FROM alpine:3.6  
LABEL maintainer="aabishkar@gmail.com"  
  
RUN apk --update --no-cache add apache2-utils  
  
ENTRYPOINT [ "/usr/bin/ab" ]  
  
CMD ["-h"]  

