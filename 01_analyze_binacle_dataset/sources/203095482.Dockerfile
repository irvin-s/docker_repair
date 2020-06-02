FROM posborne/rust-cross:base

# Setup PATH to allow running android tools.
ENV PATH=$PATH:/android/ndk-arm/bin:\
/android/ndk-aarch64/bin:\
/android/ndk-x86:\
/android/sdk/tools:\
/android/sdk/platform-tools \
ANDROID_FORCE_EMULATOR_32BIT=true

RUN dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends \
        expect \
        libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
        openjdk-6-jre psmisc \
        && \
    apt-get clean

# Install NDK/SDK
ADD install-ndk.sh /android/
RUN cd /android && sh /android/install-ndk.sh
ADD install-sdk.sh accept-licenses.sh /android/
RUN cd /android && sh /android/install-sdk.sh

# Install Rust Versions
ENV RUST_TARGETS="arm-linux-androideabi"
RUN bash /rust-cross/install_rust.sh
