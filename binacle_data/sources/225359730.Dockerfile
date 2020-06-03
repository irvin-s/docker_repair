# Image pubnative/android

FROM drecom/centos-ruby

LABEL maintainer="Eros Garcia Ponte <eros902002@googlemail.com>"

WORKDIR /usr/local/

# Install Development Tools
RUN yum -y update \
 && yum -y groupinstall "Development Tools" \
 : Install ruby for fastlane and 32bits libs \
 && yum install -y glibc.i686 \
                   libstdc++.i686 \
                   glibc-devel.i686 \
                   zlib-devel.i686 \
                   ncurses-devel.i686 \
                   libX11-devel.i686 \
                   libXrender.i686 \
 && gem install bundler -v 1.7.3

# Install Java 1.8 in CentOS/RHEL 7.X
RUN cd /usr/local/ \
 && curl -s -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm > jdk-8u131-linux-x64.rpm \
 && yum -y localinstall jdk-8u131-linux-x64.rpm

# Java environment variables
ENV JAVA_VERSION 1.8
ENV JAVA_HOME /usr/java/jdk1.8.0_131
ENV JRE_HOME /usr/java/jdk1.8.0_131/jre
ENV PATH $PATH:/usr/java/jdk1.8.0_131/bin:/usr/java/jdk1.8.0_131/jre/bin

# Install Android SDK
RUN mkdir -p /usr/local/android-sdk \
 && cd /usr/local/android-sdk \
 && curl -L -O https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
 && unzip sdk-tools-linux-3859397.zip

# Install Android tools
RUN /usr/local/android-sdk/tools/bin/sdkmanager --update <<< 'y'
RUN yes | /usr/local/android-sdk/tools/bin/sdkmanager "platforms;android-28" "build-tools;28.0.3" "extras;google;m2repository" "extras;android;m2repository"
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter android-28 --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter platform-tools --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter tools --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter extra --no-ui --force -a

RUN cd /usr/local/ && ls -la

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANT_HOME/bin

# Clean up
RUN yum clean all
RUN rm -rf /usr/local/sdk-tools-linux-3859397.zip /usr/local/jdk-8u131-linux-x64.rpm /var/cache/yum
