# Docker file inspired by 
## https://github.com/docker-library/buildpack-deps/blob/a0a59c61102e8b079d568db69368fb89421f75f2/sid/curl/Dockerfile
## https://github.com/jenkinsci/docker
## https://github.com/docker-library/java/blob/b4a3c296023e590e410f645ab83d3c11a30cf535/openjdk-8-jdk/Dockerfile
## https://github.com/zulu-openjdk/zulu-openjdk/blob/master/debian/8u45-8.7.0.5/Dockerfile
## https://github.com/zulu-openjdk/zulu-openjdk/blob/master/debian/8u66-8.11.0.1/Dockerfile

FROM debian:sid-slim
MAINTAINER erik-dev@fjas.no

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/maven-infrastructure/docker-baseimages/alpine-zulu-jdk9/Dockerfile" \
      org.label-schema.license="Apache License - Version 2.0" \
      org.label-schema.name="Maven Docker Infrastructure - Zulu JDK9 Baseimage" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Github" \
      org.label-schema.vcs-url="https://github.com/Cantara/maven-infrastructure"


RUN echo "export TERM=xtermc" >> ~/.bashrc
# use norwegian debian mirror to speed up downloads
#RUN echo "deb http://ftp.no.debian.org/debian/ sid main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \ 
	ca-certificates curl wget zip unzip bzip2 vim less \
	&& rm -rf /var/lib/apt/lists/*


RUN echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
RUN echo "alias la='ls -la --color=auto'" >> /etc/bash.bashrc

ENV LANG C.UTF-8

### Install JDK 
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

# Pull Zulu OpenJDK binaries from official repository:
# Jenkins Docker image has a reference to /usr/lib/jvm/zulu-8-amd64/ in config.xml. Review if changing to different jdk.
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin
RUN \
  checksum="22c0564-cd07ef8-558feaef85100" && \
  url="http://cdn.azul.com/zulu/bin/zulu9.0.4.1-jdk9.0.4-linux_x64.tar.gz" && \
  referer="http://www.azulsystems.com/zuludoc" && \
  etag=$(curl -sI --referer "${referer}" "${url}" | awk -F"\"|:" '/^ETag: / {print $3}') && \
#  if [ "X${checksum}" == "X${etag}" ]; then \
    curl -O -L --referer "${referer}" "${url}"; \
#  else \
#    echo "[FATAL] Java ZIP ETag ${etag} doesn't match checksum ${checksum}. Exiting." >&2 && \
#    exit 1; \
#  fi && \
  tar -xzf  zulu*.gz && \
  rm zulu*.gz  
#  mkdir -p $(dirname ${JAVA_HOME}) && \
#  mv * ${JAVA_HOME} && \
#  cd .. && \
#  rmdir ${OLDPWD} && \
#  cd ${JAVA_HOME} && \
#  rm -rf *.zip demo man sample && \
#  for ff in ${JAVA_HOME}/bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done && \
#  chmod a+w ${JRE}/lib ${JRE}/lib/net.properties && \
#  rm -rf /var/cache/apk/*


RUN mv zul* /usr/local/java
RUN ln -s /usr/local/java/bin/java /bin/java

# see CA_CERTIFICATES_JAVA_VERSION notes above
# RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
