FROM openjdk:7  
MAINTAINER crane "crane.liu@qq.com"  
ENV TZ "Asia/Shanghai"  
# Install required packages  
# RUN apk add --no-cache --update\  
RUN apt-get update && apt-get install -y --no-install-recommends \  
unzip \  
bash \  
python  
  
ARG JSTORM_VERSION=2.2.1  
ARG DISTRO_NAME=jstorm-${JSTORM_VERSION}  
ARG JSTORM_INSTALL_PATH=/opt  
ENV JSTORM_HOME ${JSTORM_INSTALL_PATH}/jstorm  
ENV PATH $PATH:$JSTORM_HOME/bin  
  
ENV JSTORM_DATA_DIR=/jdata \  
JSTORM_LOG_DIR=/jlogs  
  
# copy Storm, untar and clean up  
COPY docker-entrypoint.sh /  
COPY file/${DISTRO_NAME}.zip /  
  
RUN set -x && \  
mkdir -p "$JSTORM_DATA_DIR" "$JSTORM_LOG_DIR" && \  
unzip "/${DISTRO_NAME}.zip" -d "${JSTORM_INSTALL_PATH}/" && \  
mv "${JSTORM_INSTALL_PATH}/${DISTRO_NAME}" "$JSTORM_HOME" && \  
mv "$JSTORM_HOME/conf/storm.yaml" "$JSTORM_HOME/conf/storm.yaml.template" && \  
chmod +x "$JSTORM_HOME/bin/jstorm" && \  
rm "/${DISTRO_NAME}.zip" && \  
chmod +x "/docker-entrypoint.sh"  
  
WORKDIR $JSTORM_HOME  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

