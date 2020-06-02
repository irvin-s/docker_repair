#  The MIT License
#
#  Copyright (c) 2016, Wombat Software UG (haftungsbeschränkt)
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

FROM docker:17.03.0-ce-dind
MAINTAINER Daniel Sachse <daniel@wombatsoftware.de>

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u121
ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN set -x \
    && apk --no-cache upgrade \
	&& apk --no-cache add openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

ENV HOME /home/jenkins

RUN apk --no-cache add bash openssh-client && \
    curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/3.7/remoting-3.7.jar && \
    chmod 755 /usr/share/jenkins && \
    chmod 644 /usr/share/jenkins/slave.jar && \
    apk del curl && \
    mkdir -p /home/jenkins/.docker/ && \
    ln -s /home/jenkins/.docker/.dockercfg /home/jenkins/.dockercfg

COPY dockerd-entrypoint.sh /usr/local/bin/
COPY jenkins-slave /usr/local/bin/

VOLUME /home/jenkins
WORKDIR /home/jenkins