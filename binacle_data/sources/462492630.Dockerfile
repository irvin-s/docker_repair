FROM debian:stable-slim as glibc-base

ARG GLIBC_VERSION=2.28
ARG GLIBC_PREFIX=/usr/glibc

RUN apt-get update && apt-get install -y \
  curl build-essential gawk bison python3 texinfo gettext \
  && \
  cd /root && \
  curl -SL http://ftp.gnu.org/gnu/glibc/glibc-${GLIBC_VERSION}.tar.gz | tar xzf - && \
  mkdir -p /root/build && cd /root/build && \
  ../glibc-${GLIBC_VERSION}/configure \
    --prefix=${GLIBC_PREFIX} \
    --libdir="${GLIBC_PREFIX}/lib" \
    --libexecdir="${GLIBC_PREFIX}/lib" \
    --enable-multi-arch \
    --enable-stack-protector=strong \
  && \
  make -j`nproc` && make DESTDIR=/root/dest install && \
  cd /root && rm -rf build glibc-${GLIBC_VERSION} && \
  cd /root/dest${GLIBC_PREFIX} && \
  ( strip bin/* sbin/* lib/* || true ) && \
  echo "/usr/local/lib" > /root/dest${GLIBC_PREFIX}/etc/ld.so.conf && \
  echo "${GLIBC_PREFIX}/lib" >> /root/dest${GLIBC_PREFIX}/etc/ld.so.conf && \
  echo "/usr/lib" >> /root/dest${GLIBC_PREFIX}/etc/ld.so.conf && \
  echo "/lib" >> /root/dest${GLIBC_PREFIX}/etc/ld.so.conf

RUN cd /root/dest${GLIBC_PREFIX} && \
  rm -rf etc/rpc var include share bin sbin/[^l]*  \
	lib/*.o lib/*.a lib/audit lib/gconv lib/getconf

#sbin/[^l]*

FROM alpine:3.8 as liberica

ARG GLIBC_PREFIX=/usr/glibc

ENV  LANG=en_US.UTF-8 \
     LANGUAGE=en_US:en
#	 LC_ALL=en_US.UTF-8

ARG LIBERICA_ROOT=/usr/lib/jvm/jdk-8u192-bellsoft
ARG LIBERICA_VERSION=1.8.0
ARG LIBERICA_VARIANT=jdk
ARG LIBERICA_RELEASE_TAG=8u192
ARG LIBERICA_USE_LITE=0

COPY --from=glibc-base /root/dest/ /

RUN LIBERICA_ARCH='' && LIBERICA_ARCH_TAG='' && \
  case `uname -m` in \
        x86_64) \
            LIBERICA_ARCH="amd64" \
            ;; \
        aarch64) \
            LIBERICA_ARCH="aarch64" \
            ;; \
        armv[67]l) \
            LIBERICA_ARCH="arm32-vfp-hflt"; \
            ;; \
        *) \
            LIBERICA_ARCH=`uname -m` \
            ;; \
  esac  && \
  RTAG="$LIBERICA_RELEASE_TAG" && if [ "x${RTAG}" = "x" ]; then RTAG="$LIBERICA_VERSION"; fi && \
  RSUFFIX="" && if [ "$LIBERICA_USE_LITE" = "1" ]; then RSUFFIX="-lite"; fi && \
  ln -s ${GLIBC_PREFIX}/lib/ld-*.so* /lib && \
  ln -s ${GLIBC_PREFIX}/etc/ld.so.cache /etc && \
  if [ "$LIBERICA_ARCH" = "amd64" ]; then ln -s /lib /lib64; fi && \
  ${GLIBC_PREFIX}/sbin/ldconfig && \
  \
  mkdir -p $LIBERICA_ROOT && \
  mkdir -p /tmp/java && \
  PKG=`echo "bellsoft-${LIBERICA_VARIANT}${LIBERICA_VERSION}-linux-${LIBERICA_ARCH}.tar.gz"` && \
  wget "https://download.bell-sw.com/java/${RTAG}/${PKG}" -O /tmp/java/jdk.tar.gz && \
  SHA1=`wget -q "https://download.bell-sw.com/sha1sum/java/${RTAG}" -O - | grep ${PKG} | cut -f1 -d' '` && \
  echo "${SHA1} */tmp/java/jdk.tar.gz" | sha1sum -c - && \
  tar xzf /tmp/java/jdk.tar.gz -C /tmp/java $LITE_VERSION_EXCLUDES && \
  find "/tmp/java/${LIBERICA_VARIANT}-${LIBERICA_VERSION}" -maxdepth 1 -mindepth 1 -exec mv "{}" "${LIBERICA_ROOT}/" \; && \
  rm -rf /tmp/java

ENV JAVA_HOME=${LIBERICA_ROOT} \
	PATH=${LIBERICA_ROOT}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
