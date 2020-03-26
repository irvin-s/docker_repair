FROM openshift/base-centos7

MAINTAINER Ben Browning <bbrownin@redhat.com>

EXPOSE 8080

LABEL io.openshift.s2i.destination="/opt/s2i/destination"

ENV APP_PATH=$HOME/app \
    ENV_PATH=$HOME/tmp/env \
    BUILD_PATH=$HOME/tmp/build \
    CACHE_PATH=$HOME/tmp/cache \
    BUILDPACK_PATH=$HOME/tmp/buildpacks \
    USER=1001 \
    PORT=8080

# Install common packages useful for buildpacks
RUN yum groupinstall -y "Development Tools"
RUN yum install -y \
        java-1.7.0-openjdk \
        java-1.7.0-openjdk-headless \
        libffi-devel \
        libyaml-devel \
        ncurses-devel \
        openssl-libs \
        python-devel \
        readline-devel \
        ruby \
        ruby-devel \
        tcl-devel
        

# Install Herokuish to detect and run buildpacks
ENV HEROKUISH_VERSION 0.3.10
RUN curl --silent -L https://github.com/gliderlabs/herokuish/releases/download/v{$HEROKUISH_VERSION}/herokuish_${HEROKUISH_VERSION}_linux_x86_64.tgz | tar -xzC /bin \
    && ln -s /bin/herokuish /build \
    && ln -s /bin/herokuish /start \
    && ln -s /bin/herokuish /exec



# CloudFoundry Java buildpack environment variables
ENV JAVA_BUILDPACK_VERSION=3.3.1 \
    OPENJDK_VERSION=1.8.0_60 \
    MEMORY_CALC_VERSION=2.0.0_RELEASE \
    MEMORY_LIMIT=2G \
    TMPDIR=$HOME/tmp
ENV JBP_CONFIG_OPEN_JDK_JRE="{jre: {version: ${OPENJDK_VERSION} }, memory_calculator: {version: ${MEMORY_CALC_VERSION} }}"

# Install the CloudFoundry Java buildpack
RUN mkdir -p $BUILDPACK_PATH/java-buildpack \
    && wget -nv -O /tmp/java-buildpack.zip "https://github.com/cloudfoundry/java-buildpack/releases/download/v${JAVA_BUILDPACK_VERSION}/java-buildpack-offline-v${JAVA_BUILDPACK_VERSION}.zip" \
    && unzip /tmp/java-buildpack.zip -d $BUILDPACK_PATH/java-buildpack/

# Make an OpenJDK build available for CentOS7
RUN wget -nv -O $BUILDPACK_PATH/java-buildpack/resources/cache/https%3A%2F%2Fdownload.run.pivotal.io%2Fopenjdk%2Fcentos6%2Fx86_64%2Fopenjdk-${OPENJDK_VERSION}.tar.gz.cached "https://download.run.pivotal.io/openjdk/centos6/x86_64/openjdk-${OPENJDK_VERSION}.tar.gz" \
    && echo -e "---\n${OPENJDK_VERSION}: https://download.run.pivotal.io/openjdk/centos6/x86_64/openjdk-${OPENJDK_VERSION}.tar.gz" > $BUILDPACK_PATH/java-buildpack/resources/cache/https%3A%2F%2Fdownload.run.pivotal.io%2Fopenjdk%2Fcentos7%2Fx86_64%2Findex.yml.cached

# Make a memory-calculator tool available for CentOS7
RUN wget -nv -O $BUILDPACK_PATH/java-buildpack/resources/cache/https%3A%2F%2Fdownload.run.pivotal.io%2Fmemory-calculator%2Fcentos6%2Fx86_64%2Fmemory-calculator-${MEMORY_CALC_VERSION}.tar.gz.cached "https://download.run.pivotal.io/memory-calculator/centos6/x86_64/memory-calculator-${MEMORY_CALC_VERSION}.tar.gz" \
    && echo -e "---\n${MEMORY_CALC_VERSION}: https://download.run.pivotal.io/memory-calculator/centos6/x86_64/memory-calculator-${MEMORY_CALC_VERSION}.tar.gz" > $BUILDPACK_PATH/java-buildpack/resources/cache/https%3A%2F%2Fdownload.run.pivotal.io%2Fmemory-calculator%2Fcentos7%2Fx86_64%2Findex.yml.cached



# CloudFoundry Node buildpack environment variables
ENV NODE_BUILDPACK_VERSION=1.5.11 \
    CF_STACK=cflinuxfs2

# Install the CloudFoundry NodeJS buildpack
RUN mkdir -p $BUILDPACK_PATH/node-buildpack \
    && wget -nv -O /tmp/node-buildpack.zip "https://github.com/cloudfoundry/nodejs-buildpack/releases/download/v${NODE_BUILDPACK_VERSION}/nodejs_buildpack-cached-v${NODE_BUILDPACK_VERSION}.zip" \
    && unzip /tmp/node-buildpack.zip -d $BUILDPACK_PATH/node-buildpack/


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
    && echo -e 'shift\neval "$@"' > $HOME/bin/setuidgid \
    && chmod +x $HOME/bin/*

# Uncomment to enable debug logging for buildpacks
# ENV TRACE=1 \
#     JBP_LOG_LEVEL=DEBUG

USER $USER
