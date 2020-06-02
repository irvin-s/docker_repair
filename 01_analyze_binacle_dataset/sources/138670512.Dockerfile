# algo (personal IPSEC VPN in the cloud) in a container
#
# docker run \
#   --rm \
#   --it \
#   -v <desired output dir>:/algo/algo-master/configs
#   andrewsardone/algo

FROM python:2.7.14-alpine3.7
MAINTAINER Andrew Sardone <andrew@andrewsardone.com>
LABEL description="Executable algo (personal IPSEC VPN)"

# Cribbed from algo's Dockerfile
# https://github.com/trailofbits/algo/blob/78830d96aa827ebe66b071a1bcfd6e5232386a67/Dockerfile
ARG PACKAGES="bash libffi openssh-client openssl rsync tini"
ARG BUILD_PACKAGES="gcc libffi-dev linux-headers make musl-dev openssl-dev"

RUN apk --no-cache add ${PACKAGES}

WORKDIR /algo

# Grab algo
# https://github.com/trailofbits/algo#deploy-the-algo-server
ADD https://github.com/trailofbits/algo/archive/master.zip .
RUN unzip master.zip
WORKDIR /algo/algo-master

RUN apk --no-cache add ${BUILD_PACKAGES} && \
  python -m pip --no-cache-dir install -U pip && \
  python -m pip --no-cache-dir install virtualenv && \
  python -m virtualenv env && \
  source env/bin/activate && \
  python -m pip --no-cache-dir install -r requirements.txt

CMD [ "./algo" ]
