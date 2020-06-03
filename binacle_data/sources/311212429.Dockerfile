FROM alpine:3.7

ARG ROFI_VERSION=1.5.1
#--virtual .build-deps \

RUN apk add --update --no-cache \
  alpine-sdk
RUN apk add         \
  bison             \
  libxkbcommon      \
  libxkbcommon-dev  \
  glib-dev          \
  xcb-util-image xcb-util-xrm xcb-util-xrm-dev xcb-util-cursor xcb-util-cursor-dev xcb-util-renderutil xcb-util-renderutil-dev xcb-util-renderutil-dev xcb-util-image xcb-util-image-dev xcb-util-wm xcb-util-wm-dev xcb-util-keysyms xcb-util-keysyms-dev xcb-proto xcb-util xcb-util-dev \
  pango-dev         \
  startup-notification-dev  \
  librsvg-dev               \
  check-dev                 \
  xkeyboard-config          \
  bash                      \
  flex                      \
  xdotool                   \
  ttf-ubuntu-font-family    \
  libxt-dev libxtst-dev libxinerama-dev \
  jq

WORKDIR /tmp
RUN curl -Lo - https://github.com/DaveDavenport/rofi/releases/download/${ROFI_VERSION}/rofi-${ROFI_VERSION}.tar.gz | tar zxvf -
WORKDIR /tmp/rofi-${ROFI_VERSION}
RUN ./configure
RUN make
RUN make install

ENV PATH /usr/local/bin/:$PATH

ADD bin/silverkey.sh /usr/local/bin/silverkey.sh
ADD bin/silverkey-lookup.sh /usr/local/bin/silverkey-lookup.sh
ADD bin/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
