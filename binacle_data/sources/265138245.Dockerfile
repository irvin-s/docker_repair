FROM alpine:3.7

#
# Java for Gradle
#

RUN apk --no-cache add openjdk8

#
# https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/alpine/Dockerfile
#

ENV CLOUD_SDK_VERSION 215.0.0

ENV PATH /google-cloud-sdk/bin:$PATH

RUN apk --no-cache add \
        curl \
        python \
        py-crcmod \
        bash \
        libc6-compat \
        openssh-client \
        git \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

#
# Other development tools
#

RUN gcloud components install app-engine-java

RUN apk --no-cache add gettext

RUN apk --no-cache add mysql
RUN apk --no-cache add mysql-client
RUN curl https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 \
  > /usr/local/bin/cloud_sql_proxy && chmod +x /usr/local/bin/cloud_sql_proxy

RUN curl https://raw.githubusercontent.com/mrako/wait-for/d9699cb9fe8a4622f05c4ee32adf2fd93239d005/wait-for \
  > /usr/local/bin/wait-for && chmod +x /usr/local/bin/wait-for

# Create a gradle cache directory as a volume that can be read/written by any
# container (including containers running as any user -- hence the a+rwx)
RUN mkdir /.gradle && chmod a+rwx -R /.gradle
VOLUME /.gradle
ENV GRADLE_USER_HOME /.gradle

# It never makes sense for Gradle to run a daemon within a docker container.
ENV GRADLE_OPTS="-Dorg.gradle.daemon=false"

RUN apk --no-cache add ruby ruby-json ruby-io-console

RUN curl https://services.gradle.org/distributions/gradle-4.3.1-bin.zip -L > /tmp/gradle.zip
WORKDIR /tmp
RUN unzip gradle.zip && rm gradle.zip \
  && mv gradle-* /gradle
ENV PATH="$PATH:/gradle/bin"
WORKDIR /

RUN gem install --no-document googleauth

RUN curl -O https://bin.equinox.io/c/htRtQZagtfg/rainforest-cli-stable-linux-amd64.tgz && \
  tar -xvf rainforest-cli-stable-linux-amd64.tgz && rm rainforest-cli-stable-linux-amd64.tgz && \
  mv rainforest /usr/local/bin

COPY with-mysql-login.sh /usr/local/bin
COPY with-uid.sh /usr/local/bin

ENTRYPOINT ["with-uid.sh"]
