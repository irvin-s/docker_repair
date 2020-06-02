FROM python:2.7-alpine3.6  
  
ENV \  
GIT_URL="https://github.com/BrainDoctor/simplemonitor.git" \  
MONITOR_FOLDER="/usr/src/simplemonitor" \  
MONITOR_ARGS="-H" \  
DEFAULT_CONFIG_FOLDER="/etc/default/simplemonitor" \  
DEFAULT_HTML_FOLDER="/etc/default/simplemonitor/html" \  
DEFAULT_CONFIG_FILE="/etc/default/simplemonitor/monitor.ini" \  
MONITOR_CONFIG_FOLDER="/etc/simplemonitor" \  
MONITOR_CONFIG_FILE="/etc/simplemonitor/global.ini" \  
MONITOR_HTML_FOLDER="/usr/src/simplemonitor/html" \  
NGINX_USER="root" \  
MONITOR_USER="root" \  
HEALTH_CHECK_INTERVAL="5"  
  
EXPOSE 8080  
  
CMD ["/bin/sh", "docker-entrypoint.sh"]  
  
HEALTHCHECK \  
\--interval=5m \  
\--timeout=3s \  
\--start-period=1m \  
\--retries=2\  
CMD /bin/sh healthcheck.sh  
  
WORKDIR $MONITOR_FOLDER  
RUN \  
apk update && \  
apk upgrade && \  
apk add \--no-cache \  
supervisor \  
nginx \  
nginx-mod-http-echo \  
git \  
bind-tools  
  
RUN \  
git clone $GIT_URL . && \  
rm -r .git && \  
pip install -r $MONITOR_FOLDER/requirements.txt && \  
mkdir -p "$DEFAULT_CONFIG_FOLDER" && \  
mv "$MONITOR_HTML_FOLDER" "$DEFAULT_HTML_FOLDER" && \  
apk del git  
  
ADD docker-entrypoint.sh healthcheck.sh $MONITOR_FOLDER/  
VOLUME $MONITOR_CONFIG_FOLDER $MONITOR_HTML_FOLDER  
COPY files /  

