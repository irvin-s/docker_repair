FROM alpine  
MAINTAINER smallweirdnum@gmail.com  
  
# To force an update of apt-get instead of a cached version  
RUN apk add --no-cache fish lynx mdocml-apropos  
  
ENV BROWSER=lynx  
  
COPY config.fish /root/.config/fish/config.fish  
  
ENTRYPOINT [ "/usr/bin/fish" ]  

