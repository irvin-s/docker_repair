FROM alpine:latest  
MAINTAINER Paul Pham <docker@aquaron.com>  
  
COPY data /data  
ENV \  
_image=aquaron/mariadb \  
_etc=/etc/mysql \  
_root=/var/lib/mysql \  
_log=/var/log/mysql \  
_sock=/var/log/mysql/mysqld.sock  
  
RUN addgroup -g 900 mysql \  
&& adduser -h $_root -g "MySQL" -u 900 -G mysql -D mysql \  
&& apk --no-cache -q add mariadb \  
&& mkdir $_log \  
&& chown -R mysql:mysql $_etc $_log $_root \  
&& mv /data/bin/* /usr/bin  
  
ONBUILD USER mysql  
ONBUILD RUN apk --no-cache -q add mariadb-client  
  
VOLUME [ $_etc, $_root, $_log ]  
ENTRYPOINT [ "runme.sh" ]  
CMD [ "daemon" ]  

