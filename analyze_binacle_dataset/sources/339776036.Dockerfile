FROM cantara/jvmprep

MAINTAINER totto@totto.org
# Based upon work by josh@grahamis.com
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
#  https://cdn.azul.com/zulu/bin/zulu8.31.0.1-jdk8.0.181-linux_x64.tar.gz
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/maven-infrastructure/docker-baseimages/alpine-zulu-jdk9/Dockerfile" \
      org.label-schema.license="Apache License - Version 2.0" \
      org.label-schema.name="Maven Docker Infrastructure - Zulu JDK8 Baseimage" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Github" \
      org.label-schema.vcs-url="https://github.com/Cantara/maven-infrastructure"
# Replace duplicate files in JDK bin with links to JRE bin
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin
RUN \
  checksum="22c04b5-4a6d06a-55551618e9740" && \
  url="http://cdn.azul.com/zulu/bin/zulu8.31.0.1-jdk8.0.181-linux_x64.tar.gz" && \
  referer="http://www.azulsystems.com/zuludoc" && \
  etag=$(curl -sI --referer "${referer}" "${url}" | awk -F"\"|:" '/^ETag: / {print $3}') && \
#  if [ "X${checksum}" == "X${etag}" ]; then \
    curl -O -L --referer "${referer}" "${url}"; \
#  else \
#    echo "[FATAL] Java ZIP ETag ${etag} doesn't match checksum ${checksum}. Exiting." >&2 && \
#    exit 1; \
#  fi && \
  tar -xzf   *.gz && \
  rm *.gz && \
  mkdir -p $(dirname ${JAVA_HOME}) && \
  mv * ${JAVA_HOME} && \
  cd .. && \
  rmdir ${OLDPWD} && \
  cd ${JAVA_HOME} && \
  rm -rf *.zip demo man sample && \
  for ff in ${JAVA_HOME}/bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done && \
  chmod a+w ${JRE}/lib ${JRE}/lib/net.properties && \
  rm -rf /var/cache/apk/*

WORKDIR /root

