FROM alpine:3.5  
ENV NODDES_VERSION 0.0.19  
ENV PATH $PATH:/opt/node-v${NODEJS_VERSION}-linux-x64/bin  
  
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh  
RUN apk add --no-cache \  
git \  
bash \  
ca-certificates \  
nodejs && \  
mkdir -p /opt/npm/ && \  
npm install -g node-deploy-essentials@${NODDES_VERSION} && \  
addgroup -g 10777 nodeworker && \  
adduser -D -G nodeworker -u 10777 nodeworker && \  
chown -R nodeworker:nodeworker /opt/ && \  
chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh  
  
#  
# WORKDIR  
#  
USER nodeworker  
VOLUME ["/opt/npm/"]  
ENV NPM_REGISTRY_MIRROR "false"  
ENTRYPOINT ["/opt/docker-entrypoint.sh"]  
WORKDIR /opt/npm/  
CMD ["ndes", "--version"]  

