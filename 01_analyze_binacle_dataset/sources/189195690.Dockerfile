#BUILD_PUSH=hub,quay
FROM bigm/base-deb

#= oracle_jdk8
# install Oracle Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java8-installer \
    && rm -rf /var/cache/oracle-jdk8-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#= .oracle_jdk8
