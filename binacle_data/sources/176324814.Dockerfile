FROM node:0.10
MAINTAINER Daniel Dent (https://www.danieldent.com/)

ENV METEOR_VERSION 1.0.3.2
ENV METEOR_INSTALLER_SHA256 4020ef4d3bc257cd570b5b2d49e3490699c52d0fd98453e29b7addfbdfba9c80
ENV METEOR_LINUX_X86_32_SHA256 4011b4584c459d0c5f234548adc6b32ff6137404b73ed374905aef99159f38cf
ENV METEOR_LINUX_X86_64_SHA256 939c992a871670a5e5bf65a6d089a4c1e519ee186cf7f20a45c71395ab1a770c
ENV TARBALL_URL_OVERRIDE https://github.com/DanielDent/docker-meteor/releases/download/v${RELEASE}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz

# 1. Download & verify the meteor installer.
# 2. Patch it to validate the meteor tarball's checksums.
# 3. Install meteor

COPY meteor-installer.patch /tmp/meteor/meteor-installer.patch
COPY vboxsf-shim.sh /usr/local/bin/vboxsf-shim
RUN curl -SL https://install.meteor.com/ -o /tmp/meteor/inst \
    && sed -e "s/^RELEASE=.*/RELEASE=\"\$METEOR_VERSION\"/" /tmp/meteor/inst > /tmp/meteor/inst-canonical \
    && echo $METEOR_INSTALLER_SHA256 /tmp/meteor/inst-canonical | sha256sum -c \
    && patch /tmp/meteor/inst /tmp/meteor/meteor-installer.patch \
    && chmod +x /tmp/meteor/inst \
    && /tmp/meteor/inst \
    && rm -rf /tmp/meteor

VOLUME /app
WORKDIR /app
EXPOSE 3000
CMD [ "meteor" ]
