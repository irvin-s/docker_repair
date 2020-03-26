# Lucidworks Banana Fusion
# https://github.com/bigcontainer/bigcont/banana
FROM centos:7

ARG BANANA_FUSION_URL=https://github.com/lucidworks/banana/archive/
ARG BANANA_FUSION_VERSION=2.4.0  fusion-2.4.0.tar.gz
ARG TARGET_DIR=/opt
ARG JETTY_VERSION 9.3.8.v20160314
ARG JAVA_VERSION=1.8.0 

ENV JAVA_HOME=/usr/lib/jvm/jre
ENV JETTY_PREFIX ${TARGET_DIR}/jetty-distribution-${JETTY_VERSION}

# Java installation
RUN \
    yum install -y java-${JAVA_VERSION}-openjdk

# Add group
RUN \
    groupadd -r banana

# Add user
RUN \
    useradd -r -u 8080 -g banana banana

RUN \
    mkdir -p ${TARGET_DIR}

# Install Jetty
WORKDIR ${TARGET_DIR}
RUN \
    curl -L http://download.eclipse.org/jetty/${JETTY_VERSION}/dist/jetty-distribution-${JETTY_VERSION}.tar.gz -o ${TARGET_DIR}/jetty-distribution-${JETTY_VERSION}.tar.gz && \
    tar xvzf jetty-distribution-${JETTY_VERSION}.tar.gz && \
    rm -f ${TARGET_DIR}/jetty-distribution-${JETTY_VERSION}.tar.gz && \
    chown -R ${BANANA_USER}:${BANANA_GROUP} ${JETTY_PREFIX} 

# Install Banana Fusion
# ENV BANANA_VERSION release-1.6.0
ENV BANANA_VERSION release
WORKDIR ${TARGET_DIR}
# RUN curl -L -o ${TARGET_DIR}/banana-${BANANA_VERSION}.zip https://github.com/lucidworks/banana/archive/${BANANA_VERSION}.zip
RUN curl -L -o ${TARGET_DIR}/banana-${BANANA_VERSION}.zip https://github.com/mosuka/banana/archive/${BANANA_VERSION}.zip
RUN unzip banana-${BANANA_VERSION}.zip && rm ${TARGET_DIR}/banana-${BANANA_VERSION}.zip
ENV BANANA_PREFIX ${TARGET_DIR}/banana-${BANANA_VERSION}
RUN chown -R ${BANANA_USER}:${BANANA_GROUP} ${BANANA_PREFIX}
WORKDIR ${BANANA_PREFIX}
RUN ant -Dfinal.name=banana

RUN cp ${BANANA_PREFIX}/build/banana.war ${JETTY_PREFIX}/webapps/.

# Add start and stop script
ADD docker-run.sh /usr/local/bin/
ADD docker-stop.sh /usr/local/bin/

ENV JETTY_HTTP_PORT=5601

EXPOSE 5601
USER ${BANANA_USER}

WORKDIR ${JETTY_PREFIX}

CMD ["/usr/local/bin/docker-run.sh"]
