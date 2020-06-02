# Image of JDK and Ruby
FROM openjdk:8

# Setup environments to android sdk
ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"
ENV ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=26 \
    ANDROID_BUILD_TOOLS_VERSION=27.0.3

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Run update and install need library
RUN apt-get update \
    && apt-get install --yes lib32stdc++6 lib32z1 ruby ruby-dev rubygems build-essential

# Install Fastlane to Deploy and MkDocs to GitHubPages
RUN gem install fastlane -NV \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && pip install mkdocs

# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# Create this empty file to work around problems in sdkmanager update
RUN touch ~/.android/repositories.cfg

# Install Android Build Tool and Libraries
RUN $ANDROID_HOME/tools/bin/sdkmanager --update \
    && $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-${ANDROID_VERSION}" \
    "platform-tools" \
    "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
    # "extra-android-m2repository" \
    # "extra-google-google_play_services" \
    # "extra-google-m2repository"
    # "system-images;android-26;google_apis_playstore;x86"

# Create an emulator
# RUN echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n nexteavd -k "system-images;android-26;google_apis_playstore;x86"

# Create workspace
RUN mkdir /application
WORKDIR /application

# Copy *.sh to execute builds
COPY ./*.sh /

RUN sed -i 's/\r//' /*.sh \
    && chmod +x /*.sh

# Set default execute command
CMD /test.sh
