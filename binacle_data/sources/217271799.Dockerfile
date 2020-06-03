FROM snowdream/gradle:3.4.1

MAINTAINER snowdream <yanghui1986527@gmail.com>

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qqy install libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 unzip tar git --no-install-recommends && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Download and unzip Android SDK
ENV ANDROID_HOME ${SDK_HOME}/android-sdk-linux
ENV ANDROID_SDK ${SDK_HOME}/android-sdk-linux
ENV ANDROID_SDK_MANAGER ${SDK_HOME}/android-sdk-linux/tools/bin/sdkmanager

ENV ANDROID_SDK_VERSION r25.2.3
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/tools_${ANDROID_SDK_VERSION}-linux.zip
RUN curl -sSL "${ANDROID_SDK_URL}" -o tools_${ANDROID_SDK_VERSION}-linux.zip \
    && unzip tools_${ANDROID_SDK_VERSION}-linux.zip -d ${ANDROID_HOME} \
  && rm -rf tools_${ANDROID_SDK_VERSION}-linux.zip
  
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# Install Android SDK Components
ENV ANDROID_COMPONENTS "tools" \
                       "platform-tools" \
                       "build-tools;25.0.2" \
                       "build-tools;25.0.1" \
                       "build-tools;25.0.0" \
                       "platforms;android-25" 

ENV GOOGLE_COMPONENTS "extras;android;m2repository" \
                       "extras;google;m2repository" \
                       "extras;google;google_play_services" 
                       
ENV CONSTRAINT_LAYOUT "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"\
                       "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

RUN mkdir -p ${ANDROID_HOME}/licenses/ && \
    echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > ${ANDROID_HOME}/licenses/android-sdk-license && \
    echo "84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license && \
    ${ANDROID_SDK_MANAGER}  ${ANDROID_COMPONENTS} \
                            ${GOOGLE_COMPONENTS} \
                            ${CONSTRAINT_LAYOUT}  
