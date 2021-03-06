FROM area9/qt:%QT_VERSION% as qt

# This image is meant to be used to compile CGI QtByteRunner for area9/web.
# Tags are not synchronized, so assume that it is meant for latest.

# It is not tailored for automation, you are supposed to bind flow folder
# manually and ensure that asmjit is present there

# TL/DR:
# ./build-image.sh
# ./run.sh
# results in artifacts folder

FROM ubuntu:xenial

ARG qt_version=5.9.2
ARG qt_path=/opt/Qt${qt_version}
ARG qt_full_path=${qt_path}/${qt_version}/gcc_64

ENV QT_VERSION=${qt_version}
ENV QT_FULL_PATH=${qt_full_path}

COPY --from=qt ${qt_path} ${qt_path}
ENV PATH="${PATH}:${qt_full_path}/bin"
RUN echo "${qt_full_path}/lib" > /etc/ld.so.conf.d/qt.conf \
  && ldconfig

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    git \
    libfcgi-dev \
    libglib2.0-0

# This is for convenience so that resulting files will belong to regular user
# instead of root. Will be useless on multi-user systems.
ARG uid=1000
ARG gid=1000
RUN addgroup --gid=${gid} flow \
  && useradd --uid=${uid} \
             --gid=${gid} \
             --no-create-home \
             --home=/flow \
             --shell=/bin/bash \
             flow

# build_image.sh takes care of preparing qbr for us
COPY qbr /flow
COPY config/buildcgi.sh /flow/platforms/qt/buildcgi.sh

RUN chown -R flow:flow /flow
                                                                                     
USER flow
WORKDIR /flow/platforms/qt
 
CMD ["./buildcgi.sh"]

