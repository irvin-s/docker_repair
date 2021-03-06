# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# React Native Android Unit Tests
#
# This image builds upon the React Native Base Android Development Environment
# image. Ideally, this image would be rebuilt with any new commit to the master
# branch. Doing so will catch issues such as BUCK failing to fetch dependencies
# or run tests, as well as unit test failures.
FROM react-native-community/react-native

LABEL Description="This image prepares and runs React Native's Android tests."
LABEL maintainer="Héctor Ramos <hector@fb.com>"

ARG BUCK_BUILD
# set default environment variables
ENV GRADLE_OPTS="-Dorg.gradle.daemon=false -Dorg.gradle.jvmargs=\"-Xmx512m -XX:+HeapDumpOnOutOfMemoryError\""
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF8"

ENV BUCK_BUILD="1"

# add ReactAndroid directory
ADD .buckconfig /app/.buckconfig
ADD .buckjavaargs /app/.buckjavaargs
ADD ReactAndroid /app/ReactAndroid
ADD ReactCommon /app/ReactCommon
ADD ReactNative /app/ReactNative
ADD keystores /app/keystores

# add third party dependencies
ADD Folly /app/Folly
ADD glog /app/glog
ADD double-conversion /app/double-conversion
ADD jsc /app/jsc
ADD v8 /app/v8

# set workdir
WORKDIR /app

# run buck fetches
RUN buck fetch ReactAndroid/src/test/java/com/facebook/react/modules
RUN buck fetch ReactAndroid/src/main/java/com/facebook/react
RUN buck fetch ReactAndroid/src/main/java/com/facebook/react/shell
RUN buck fetch ReactAndroid/src/test/...
RUN buck fetch ReactAndroid/src/androidTest/...

# build app
RUN buck build ReactAndroid/src/main/java/com/facebook/react
RUN buck build ReactAndroid/src/main/java/com/facebook/react/shell

ADD gradle /app/gradle
ADD gradlew /app/gradlew
ADD settings.gradle /app/settings.gradle
ADD build.gradle /app/build.gradle
ADD react.gradle /app/react.gradle

# run gradle downloads
RUN ./gradlew :ReactAndroid:downloadBoost # :ReactAndroid:downloadDoubleConversion :ReactAndroid:downloadFolly :ReactAndroid:downloadGlog :ReactAndroid:downloadJSC

# compile native libs with Gradle script, we need bridge for unit and integration tests
RUN ./gradlew :ReactAndroid:packageReactNdkLibsForBuck -Pjobs=1

# add all react-native code
ADD . /app
WORKDIR /app

# build node dependencies
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get install yarn
RUN yarn

WORKDIR /app
