FROM cloudfoundry/cflinuxfs2:1.75.0

MAINTAINER Ben Browning <bbrownin@redhat.com>

EXPOSE 8080

LABEL io.openshift.s2i.destination="/opt/s2i/destination" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

ENV \
    # Variables copied from OpenShift's s2i-base
    STI_SCRIPTS_PATH=/usr/libexec/s2i \
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH\
    # Variables needed by Herokuish for buildpacks
    APP_PATH=$HOME/app \
    ENV_PATH=$HOME/tmp/env \
    BUILD_PATH=$HOME/tmp/build \
    CACHE_PATH=$HOME/tmp/cache \
    BUILDPACK_PATH=$HOME/tmp/buildpacks \
    # Other variables
    USER=1001 \
    PORT=8080

# Setup copied from OpenShift's s2i-base
RUN mkdir -p ${HOME}/.pki/nssdb && \
    chown -R 1001:0 ${HOME}/.pki && \
    useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
        -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

WORKDIR ${HOME}
        

# Install Herokuish to detect and run buildpacks
ENV HEROKUISH_VERSION 0.3.10
RUN curl --silent -L https://github.com/gliderlabs/herokuish/releases/download/v{$HEROKUISH_VERSION}/herokuish_${HEROKUISH_VERSION}_linux_x86_64.tgz | tar -xzC /bin \
    && ln -s /bin/herokuish /build \
    && ln -s /bin/herokuish /start \
    && ln -s /bin/herokuish /exec



# CloudFoundry buildpack environment variables
ENV JAVA_BUILDPACK_VERSION=3.8.1 \
    NODE_BUILDPACK_VERSION=1.5.18 \
    RUBY_BUILDPACK_VERSION=1.6.21 \
    CF_STACK=cflinuxfs2 \
    MEMORY_LIMIT=2G \
    TMPDIR=$HOME/tmp

# Install the CloudFoundry Java buildpack
RUN mkdir -p $BUILDPACK_PATH/java-buildpack \
    && wget -nv -O /tmp/java-buildpack.zip "https://github.com/cloudfoundry/java-buildpack/releases/download/v${JAVA_BUILDPACK_VERSION}/java-buildpack-offline-v${JAVA_BUILDPACK_VERSION}.zip" \
    && unzip /tmp/java-buildpack.zip -d $BUILDPACK_PATH/java-buildpack/


# Install the CloudFoundry NodeJS buildpack
RUN mkdir -p $BUILDPACK_PATH/node-buildpack \
    && wget -nv -O /tmp/node-buildpack.zip "https://github.com/cloudfoundry/nodejs-buildpack/releases/download/v${NODE_BUILDPACK_VERSION}/nodejs_buildpack-cached-v${NODE_BUILDPACK_VERSION}.zip" \
    && unzip /tmp/node-buildpack.zip -d $BUILDPACK_PATH/node-buildpack/


# Install the CloudFoundry Ruby buildpack
RUN mkdir -p $BUILDPACK_PATH/ruby-buildpack \
    && wget -nv -O /tmp/ruby-buildpack.zip "https://github.com/cloudfoundry/ruby-buildpack/releases/download/v${RUBY_BUILDPACK_VERSION}/ruby_buildpack-cached-v${RUBY_BUILDPACK_VERSION}.zip" \
    && unzip /tmp/ruby-buildpack.zip -d $BUILDPACK_PATH/ruby-buildpack/


# Copy our OpenShift S2I scripts
RUN mkdir -p $STI_SCRIPTS_PATH
COPY bin/assemble bin/run bin/vcap_env /${STI_SCRIPTS_PATH}/

# Tie up loose ends
RUN mkdir -p /opt/s2i/destination/src \
    && chmod -R go+rw /opt/s2i/destination \
    && chmod +x $STI_SCRIPTS_PATH/* \
    && mkdir -p $APP_PATH \
    && chown -R $USER:$USER $APP_PATH \
    && chmod -R go+rw $APP_PATH \
    && mkdir -p $HOME/tmp \
    && chown -R $USER:$USER $HOME/tmp \
    && chmod -R go+rw $HOME/tmp

# Herokuish is already running as an unprivileged user so stub out
# any usermod commands it uses.
# TODO: Long-term, fork Herokuish to work natively on CentOS / RHEL
RUN mkdir -p $HOME/bin \
    && echo '' > $HOME/bin/usermod \
    && echo '' > $HOME/bin/chown \
    && echo 'shift\neval "$@"' > $HOME/bin/setuidgid \
    && chmod +x $HOME/bin/*

# Uncomment to enable debug logging for buildpacks
# ENV TRACE=1 \
#     JBP_LOG_LEVEL=DEBUG

USER $USER
