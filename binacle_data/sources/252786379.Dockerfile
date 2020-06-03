FROM dockage/alpine-runit:3.5-5  
MAINTAINER Mohammad Abdoli Rad <m.abdolirad@gmail.com>  
  
ENV TINYDNS_USER=tinydns \  
TINYDNS_GROUP=tinydns \  
DOCKAGE_ETC_DIR=/etc/dockage  
  
ADD ./assets ${DOCKAGE_ETC_DIR}  
  
RUN apk update \  
&& apk --no-cache add tinydns \  
&& runit-enable-service tinydns \  
&& mv ${DOCKAGE_ETC_DIR}/sbin/* /sbin \  
&& rm -rf /var/cache/apk/* ${DOCKAGE_ETC_DIR}/sbin  
  
EXPOSE 53/udp  
  
VOLUME ["/var/cache/tinydns"]  
  
ENTRYPOINT ["/sbin/entrypoint"]  
CMD ["app:start"]

