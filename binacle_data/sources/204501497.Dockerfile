FROM ubuntu:16.04
MAINTAINER Mika <mika@recalbox.com>

# USER ENV
# auto build recalbox when running
ENV RECALBOX_AUTO_BUILD 1
# recalbox fork to pull
ENV RECALBOX_FORK recalbox
# recalbox github branch to compile
ENV RECALBOX_BRANCH rb-4.1.X
# recalbox target arch
ENV RECALBOX_ARCH rpi3
# clean before build when rebuilding
ENV RECALBOX_CLEANBUILD 1
# use parent folder for downloads
ENV RECALBOX_DL_PARENT_FOLDER 0
# use parent folder for host builds
ENV RECALBOX_HOST_PARENT_FOLDER 0
# git reset --hard HEAD before pulling
ENV RECALBOX_GIT_RESET 1
# recalbox version to use for recalbox.version
ENV RECALBOX_VERSION_LABEL ""
# recalbox message to show on update
ENV RECALBOX_UPDATE_MESSAGE ""
# recalbox commit to checkout
ENV RECALBOX_GIT_COMMIT ""

ENV TERM xterm

# Install dependencies
# needed ? xterm
RUN apt-get update -y && \
apt-get -y install build-essential git libncurses5-dev qt5-default qttools5-dev-tools \
mercurial libdbus-glib-1-dev texinfo zip openssh-client libxml2-utils \
software-properties-common wget cpio bc locales rsync imagemagick \
nano vim automake mtools dosfstools subversion openjdk-8-jdk libssl-dev && \
rm -rf /var/lib/apt/lists/*

# Set the locale needed by toolchain
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

RUN mkdir -p /usr/share/recalbox
WORKDIR /usr/share/recalbox

ADD ./bin /usr/local/bin

CMD ["/usr/local/bin/start.sh"]
