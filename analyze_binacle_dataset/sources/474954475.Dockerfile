ARG ANDROID_STUDIO_IMAGE=tddpirate/androidstudio:1.4
FROM $ANDROID_STUDIO_IMAGE
MAINTAINER Omer Zak "w1@zak.co.il"
RUN sudo npm install -g cordova && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
      gradle less

USER developer
# ENV HOME=/AndroidStudio/home DISPLAY=:0 SHELL=/bin/bash
# ENV ANDROID_HOME=$HOME/Android/Sdk
# ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
ENV JAVA_HOME=/AndroidStudio/home/android-studio/jre ANDROID_SDK_ROOT=$ANDROID_HOME
ENV PATH=$ANDROID_HOME/emulator:$PATH:$ANDROID_HOME/tools/bin:$JAVA_HOME/bin

ENTRYPOINT /bin/bash