FROM alpine  
  
MAINTAINER Piotr Gaczkowski <DoomHammerNG@gmail.com>  
  
RUN apk --update --upgrade add zsh && \  
rm -rf /var/cache/apk/* \  
&& find / -type f -iname \\*.apk-new -delete \  
&& rm -rf /var/cache/apk/*  
  
ENV SHELL=/bin/zsh  
  
ENTRYPOINT ["zsh"]  

