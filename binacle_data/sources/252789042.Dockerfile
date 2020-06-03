# vim:set ft=dockerfile:  
FROM drupalwxt/selenium:base  
MAINTAINER William Hearn <sylus1984@gmail.com>  
  
ENV HUB_HOST hub  
ENV HUB_PORT 4444  
RUN apk --update --no-cache add \  
dbus \  
firefox \  
ttf-freefont \  
xvfb  
  
RUN dbus-uuidgen > /var/lib/dbus/machine-id  
  
COPY scripts/entrypoint.sh $SELENIUM_DIR  
ENTRYPOINT ["./entrypoint.sh"]  

