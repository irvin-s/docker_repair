FROM        openjdk:8-jdk-alpine

ENV         ANDROID_BUILD_TOOLS 27.0.0
ENV         ANDROID_PLATFORM 27
ENV         ANDROID_SDK 3859397
ENV         GLIBC "2.25-r0"

# Install wget and unzip; add SSL certs to wget
RUN         apk update
RUN         apk add --no-cache ca-certificates wget bash
RUN         update-ca-certificates

# Install glibc for Android SDK
RUN         wget -q https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub
RUN         wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk -O /tmp/glibc.apk
RUN         wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-bin-$GLIBC.apk -O /tmp/glibc-bin.apk
RUN         apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk
RUN         rm /tmp/glibc.apk /tmp/glibc-bin.apk /etc/apk/keys/sgerrand.rsa.pub

# Install Sbt
RUN         wget -q https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt -O /bin/sbt
RUN         chmod +x /bin/sbt

# Install Android SDK
RUN         mkdir /android-sdk
RUN         wget -q -O /android-sdk/android-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK.zip
RUN         cd /android-sdk && unzip -q ./android-tools.zip
RUN         rm /android-sdk/android-tools.zip
ENV         ANDROID_HOME /android-sdk/
ENV         PATH $PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/

# Install major Android SDK components (tools/bin/sdkmanager --list)
RUN         yes | /android-sdk/tools/bin/sdkmanager \
                "platform-tools" \
                "tools" \
                "build-tools;$ANDROID_BUILD_TOOLS" \
                "platforms;android-$ANDROID_PLATFORM" \
                "extras;android;m2repository" \
                "extras;google;m2repository"

RUN         mkdir -p /cache/project/
RUN         mkdir -p /cache/src/main/
RUN         mkdir -p /cache/src/test/scala/
ADD         ./build.sbt /cache/
ADD         ./project/build.properties ./project/plugins.sbt /cache/project/
RUN         echo "class Test" > /cache/src/test/scala/Test.scala
RUN         echo "<manifest package=\"com.example\" />" > /cache/src/main/AndroidManifest.xml
RUN         cd /cache/ && sbt test
RUN         rm -rf ./cache/

WORKDIR     /app/