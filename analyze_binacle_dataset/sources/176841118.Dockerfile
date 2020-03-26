FROM ubuntu:14.10

MAINTAINER Guillaume Fillon <guillaume@posteo.de>

ENV ANDROID_SDK_VERSION android-sdk_r24.0.1-linux

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-7-jdk libc6:i386 libncurses5:i386 libstdc++6:i386 x11vnc xvfb x11-apps:i386 && \
    apt-get install -y --no-install-recommends wget git imagemagick && \
    apt-get clean

WORKDIR /src

# Other tools and resources of Android SDK
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

ADD wait-for-emulator /usr/local/bin/
ADD start-emulator /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for-emulator /usr/local/bin/start-emulator

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

EXPOSE 5900