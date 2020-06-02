FROM gliderlabs/alpine:3.3  
  
MAINTAINER "Anthony O."  
ADD znc-alpine/build/znc-build*.tar.gz /  
  
RUN apk add \--no-cache \  
icu-libs \  
libstdc++ \  
libgcc \  
openssl  
  
RUN adduser -D -h /home/znc -s /bin/false znc znc \  
&& ln -s /home/znc/bin/znc /usr/local/bin/  
  
# RUN adduser znc znc  
# WORKDIR /home/znc/bin/  
  
USER znc  
  
RUN export PATH=/home/znc/bin:$PATH  
  
CMD znc -f  
  
# docker run -it -v $(pwd)/.znc:/home/znc/.znc -p 1234:1234 zncapp znc

