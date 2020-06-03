# ----------------------------------------------------------------------
# Numenta Platform for Intelligent Computing (NuPIC)
# Copyright (C) 2015, Numenta, Inc.  Unless you have purchased from
# Numenta, Inc. a separate commercial license for this software code, the
# following terms and conditions apply:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero Public License for more details.
#
# You should have received a copy of the GNU Affero Public License
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# http://numenta.org/licenses/
# ----------------------------------------------------------------------

FROM ubuntu:14.04

# Install dependencies
RUN apt-get update;\
apt-get install -y wget git-core default-jdk lib32stdc++6 lib32z1

# Download and install android-sdk
RUN wget -qO- http://dl.google.com/android/android-sdk_r24.2-linux.tgz | /bin/tar xz
RUN mkdir -p /usr/local/opt; mv android-sdk-linux /usr/local/opt/android-sdk
ENV ANDROID_HOME /usr/local/opt/android-sdk

# Add android tools and platform tools to PATH
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Update android latest tools
RUN echo y | android update sdk --all --no-ui --force --filter \
tools,platform-tools,extra-android-m2repository,extra-google-m2repository,\
extra-android-support
# Version specific build tools and system images
RUN echo y | android update sdk --all --no-ui --force --filter \
android-22,build-tools-22.0.1,android-16,sys-img-armeabi-v7a-android-16

# Set up emulator
RUN echo no | android create avd --force -n test -t android-16
RUN echo "emulator -avd test -no-boot-anim -no-skin -no-audio -no-window -force-32bit &" > /usr/local/bin/start-emulator;\
chmod a+x /usr/local/bin/start-emulator

# Download latest local dynamodb tool
WORKDIR /opt/numenta/dynamodb
RUN wget -qO- https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz | tar xz
RUN echo "java -Djava.library.path=/opt/numenta/dynamodb/DynamoDBLocal_lib -jar /opt/numenta/dynamodb/DynamoDBLocal.jar -inMemory -sharedDb &" > /usr/local/bin/start-dynamodb;\
chmod a+x /usr/local/bin/start-dynamodb

# Create "products" mount point
RUN mkdir -p /opt/numenta/products/taurus-mobile/android
RUN echo "echo 'Map your repository to \"/opt/numenta/products\"'" > \
/opt/numenta/products/taurus-mobile/android/gradlew;\
chmod +x /opt/numenta/products/taurus-mobile/android/gradlew
VOLUME /opt/numenta/products

# Move application signing keystore to default location
ADD .keys/htmit.keystore /etc/numenta/products/keys/htmit.keystore

# Build taurus-mobile
WORKDIR /opt/numenta/products/taurus-mobile/android
CMD start-dynamodb;start-emulator;adb wait-for-device;./gradlew clean build connectedCheck

