FROM        busybox
MAINTAINER  Joel Bastos <kintoandar@gmail.com>

ENV VERSION "1.0.0"
ENV ARCH "linux_386"
ENV SRC_PORT "80"

ADD "https://dl.bintray.com/kintoandar/fwd/${VERSION}/fwd_${ARCH}" /bin/fwd
RUN chmod +x "/bin/fwd"

EXPOSE "${SRC_PORT}"
ENTRYPOINT /bin/fwd --from 0.0.0.0:"$SRC_PORT" --to "$TO" 
