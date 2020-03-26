
ARG ndk_version=android-ndk-r17b
ARG android_ndk_home=/opt/android/${ndk_version}

# install NDK
RUN curl --silent --show-error --location --fail --retry 3 --output /tmp/${ndk_version}.zip https://dl.google.com/android/repository/${ndk_version}-linux-x86_64.zip && \
    sudo unzip -q /tmp/${ndk_version}.zip -d /opt/android && \
    rm /tmp/${ndk_version}.zip && \
    sudo chown -R circleci:circleci ${android_ndk_home}

ENV ANDROID_NDK_HOME ${android_ndk_home}
