FROM autocaseimpact/python3-uwsgi-node:alpine  
  
# Install the required libraries for wkhtmltopdf  
RUN apk update && apk upgrade && apk add --no-cache --update \  
wkhtmltopdf@edge-testing \  
coreutils \  
xvfb \  
dbus \  
&& rm -rf /var/cache/apk/* # Delete the cache folder to save some space  
  
# Install xvfb to use wkhtmltopdf without X server  
ADD ./packages/wkhtmltopdf /usr/local/bin/  
ADD ./packages/xvfb-run /usr/bin/  
  
RUN chmod a+x /usr/local/bin/wkhtmltopdf  
RUN chmod +x /usr/bin/xvfb-run  

