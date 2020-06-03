FROM snowdream/android:25

MAINTAINER snowdream <yanghui1986527@gmail.com>

# Install Android NDK Components
ENV ANDROID_NDK_COMPONENTS "ndk-bundle" \
                       "lldb;2.3" \
                       "cmake;3.6.3155560"
                       
RUN ${ANDROID_SDK_MANAGER} ${ANDROID_NDK_COMPONENTS}  

ENV ANDROID_NDK_HOME ${ANDROID_SDK}/ndk-bundle
ENV PATH ${ANDROID_NDK_HOME}:$PATH
