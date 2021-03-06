FROM ubuntu:18.04

ARG APPIUM_VERSION="1.8.1"

RUN \
    apt update && \
    apt remove -y libcurl4 && \
    apt install -y apt-transport-https ca-certificates tzdata locales libcurl4 curl gnupg && \
	curl --silent --location https://deb.nodesource.com/setup_10.x | bash - && \
	apt install -y --no-install-recommends \
	    curl \
	    iproute2 \
	    nodejs \
	    openjdk-8-jre-headless \
	    unzip \
	    xvfb \
	    libpulse0 \
        fluxbox \
        x11vnc \
        feh \
        wmctrl \
	    libglib2.0-0 && \
    apt-get clean && \
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

RUN cd / && npm install --prefix ./opt/ appium@$APPIUM_VERSION

COPY android.conf /etc/ld.so.conf.d/
COPY fluxbox/aerokube /usr/share/fluxbox/styles/
COPY fluxbox/init /root/.fluxbox/
COPY fluxbox/aerokube.png /usr/share/images/fluxbox/

# Android SDK
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH /opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/tools/bin:/opt/android-sdk-linux/emulator:$PATH
ENV LD_LIBRARY_PATH ${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/gles_swiftshader:${LD_LIBRARY_PATH}
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ARG ANDROID_DEVICE=""
ARG AVD_NAME="android6.0-1"
ARG BUILD_TOOLS="build-tools;23.0.1"
ARG PLATFORM="android-23"
ARG EMULATOR_IMAGE="system-images;android-23;default;x86"
ARG EMULATOR_IMAGE_TYPE="default"
ARG SDCARD_SIZE="500"
ARG USERDATA_SIZE="500"

RUN \
	curl -o sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
	mkdir -p /opt/android-sdk-linux && \
	unzip -q sdk-tools.zip -d /opt/android-sdk-linux && \
	rm sdk-tools.zip && \
	yes | sdkmanager --licenses && \
	sdkmanager "emulator" "tools" "platform-tools" "$BUILD_TOOLS" "platforms;$PLATFORM" "$EMULATOR_IMAGE" && \
	mksdcard "$SDCARD_SIZE"M sdcard.img && \
	echo "no" | ( \
	    ([ -n "$ANDROID_DEVICE" ] && avdmanager create avd -n "$AVD_NAME" -k "$EMULATOR_IMAGE" --abi x86 --device "$ANDROID_DEVICE" --sdcard /sdcard.img ) || \
	    avdmanager create avd -n "$AVD_NAME" -k "$EMULATOR_IMAGE" --abi x86 --sdcard /sdcard.img \
    ) && \
	ldconfig && \
	resize2fs /root/.android/avd/$AVD_NAME.avd/userdata.img "$USERDATA_SIZE"M && \
	mv /root/.android/avd/$AVD_NAME.avd/userdata.img /root/.android/avd/$AVD_NAME.avd/userdata-qemu.img && \
	rm /opt/android-sdk-linux/system-images/$PLATFORM/$EMULATOR_IMAGE_TYPE/x86/userdata.img

COPY emulator-snapshot.sh tmp/chromedriver* *.apk /usr/bin/

# Entrypoint
COPY tmp/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
