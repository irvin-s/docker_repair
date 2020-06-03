FROM praekeltfoundation/vumi  
  
RUN apt-get-install.sh nodejs npm && \  
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 50  
  
ENV VXSANDBOX_VERSION "0.6.1"  
RUN pip install vxsandbox==$VXSANDBOX_VERSION  
  
RUN npm install moment \  
url \  
querystring \  
crypto \  
lodash \  
q \  
jed \  
vumigo_v01 \  
vumigo_v02 \  
go-jsbox-location \  
go-jsbox-metrics-helper \  
go-jsbox-ona \  
go-jsbox-xform  
  
# Workaround for sandboxed application losing context - manually install the  
# *dependencies* globally.  
# See https://github.com/praekelt/vumi-sandbox/issues/15  
RUN mv ./node_modules /usr/local/lib/  
COPY ./go-app.js /app/app.js  
COPY ./conf/app-config.json /app/config.json  
COPY ./conf/jssandbox.yaml /app/config.yaml  
  
ENV WORKER_CLASS="vxsandbox.worker.StandaloneJsFileSandbox" \  
CONFIG_FILE="config.yaml" \  
AMQP_HOST="rabbitmq"  

