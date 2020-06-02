FROM alpine:3.6  
MAINTAINER Adam Dodman <adam.dodman@gmx.com>  
  
ENV UID=903 UNAME=headphones GID=900 GNAME=media  
  
ADD start.sh /start.sh  
  
RUN chmod +x /start.sh \  
&& addgroup -g $GID $GNAME \  
&& adduser -SH -u $UID -G $GNAME -s /usr/sbin/nologin $UNAME \  
&& apk --update --no-cache add git python \  
&& mkdir /headphones && chown $UID:$GID /headphones  
  
USER headphones  
RUN git clone \--depth=1 https://github.com/rembo10/headphones.git /headphones  
  
VOLUME ["/config", "/media"]  
EXPOSE 8181  
CMD ["/start.sh"]  

