# https://hub.docker.com/r/webratio/groovy/~/dockerfile/
# https://hub.docker.com/r/qlik/gradle/~/dockerfile/

FROM webratio/gvm

# Defines environment variables
ENV GROOVY_VERSION 2.3.9

# Installs Groovy
RUN /bin/bash -c "source /root/.gvm/bin/gvm-init.sh && gvm install groovy ${GROOVY_VERSION}"
ENV GROOVY_HOME /root/.gvm/groovy/current
ENV PATH $GROOVY_HOME/bin:$PATH

ENV GRADLE_VERSION 2.6

WORKDIR /usr/bin
RUN curl -sLO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
  unzip gradle-${GRADLE_VERSION}-all.zip && \
  ln -s gradle-${GRADLE_VERSION} gradle && \
  rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# COPY .gradle/ /root/.gradle/
