FROM node:9-stretch

ARG CI
ENV CI=$CI

ARG NO_ANDROID
ENV NO_ANDROID=$NO_ANDROID

ADD package.json yarn.lock .yarnrc docker/bootstrap-sdk.sh /opt/orbs/

WORKDIR /opt/orbs

ENV PROJECT_TYPE="sdk"
ENV SDK_HOME="/opt"
ENV GRADLE_VERSION="4.6"
ENV ANDROID_TARGET_SDK="android-27"
ENV ANDROID_SDK_TOOLS="3859397"
ENV ANDROID_BUILD_TOOLS="build-tools-27.0.3"
ENV ANDROID_NDK_VERSION="r16b"

ENV GRADLE_HOME="${SDK_HOME}/gradle-${GRADLE_VERSION}"
ENV ANDROID_HOME="${SDK_HOME}/Android/sdk"
ENV ANDROID_NDK_HOME="${ANDROID_HOME}/ndk-bundle"

RUN ./bootstrap-sdk.sh

ENV PATH="${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmake/bin:${ANDROID_NDK_HOME}:${PATH}"

RUN yarn config list && \
    yarn global add typescript@2.7.1 tslint@5.9.1 && \
    yarn install && yarn cache clean
