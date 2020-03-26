## Forked from https://registry.hub.docker.com/u/jacekmarchwicki/android/dockerfile/
FROM java:8

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz && tar xzf android-sdk.tgz --no-same-owner && rm -f android-sdk.tgz

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21.1.2,android-21,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,sys-img-armeabi-v7a-android-21"]

RUN which adb
RUN which android

# Create emulator
RUN echo "no" | android create avd \
                --force \
                --device "Nexus 5" \
                --name test \
                --target android-21 \
                --abi armeabi-v7a \
                --skin WVGA800 \
                --sdcard 512M

# Cleaning
RUN apt-get clean

CMD ["/bin/bash"]
RUN cd /opt; wget https://services.gradle.org/distributions/gradle-2.2.1-bin.zip; unzip -o gradle-2.2.1-bin.zip

WORKDIR /app
