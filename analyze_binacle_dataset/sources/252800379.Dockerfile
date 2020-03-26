FROM frolvlad/alpine-glibc  
  
MAINTAINER Michael Friebe, <michael@friebe.it>  
RUN apk update \  
&& apk upgrade \  
&& apk add \--no-cache --update rsync \  
&& adduser -D -h /home/container container  
  
USER container  
ENV USER container  
ENV HOME /home/container  
WORKDIR /home/container  
  
COPY ./entrypoint.sh /entrypoint.sh  
  
CMD ["/bin/ash", "/entrypoint.sh"]  

