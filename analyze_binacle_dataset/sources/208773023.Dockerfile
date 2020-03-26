FROM java:latest

ENV url https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
ENV sdkFile android-sdk_r24.4.1-linux.tgz

WORKDIR /root/

RUN wget $url && tar -xvzf $sdkFile

WORKDIR android-sdk-linux

RUN echo "y" | tools/android update sdk --no-ui -t 2

WORKDIR platform-tools
