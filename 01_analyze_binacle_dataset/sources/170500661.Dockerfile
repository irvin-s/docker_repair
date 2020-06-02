FROM ubuntu:14.04
MAINTAINER Carlos Moro <cmoro@deusto.es>

# Set locales
RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_GB.UTF-8

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Create editor userspace
RUN groupadd play
RUN useradd play -m -g play -s /bin/bash
RUN passwd -d -u play
RUN echo "play ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/play
RUN chmod 0440 /etc/sudoers.d/play
RUN mkdir /home/play/Code
RUN chown play:play /home/play/Code

# Install dependencies
ENV ACTIVATOR_VERSION 1.3.12
RUN apt-get update && \
    apt-get install -y git build-essential curl wget zip unzip software-properties-common
WORKDIR /tmp

# Install play
RUN wget http://downloads.typesafe.com/typesafe-activator/${ACTIVATOR_VERSION}/typesafe-activator-${ACTIVATOR_VERSION}.zip && \
    unzip typesafe-activator-${ACTIVATOR_VERSION}.zip && \
    mv activator-dist-${ACTIVATOR_VERSION} /opt/activator && \
    chown -R play:play /opt/activator && \
    rm typesafe-activator-${ACTIVATOR_VERSION}.zip

# Install Java and dependencies
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer wget unzip tar && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN echo "export PATH=$PATH:/opt/activator/bin" >> /home/play/.bashrc
#Based on https://github.com/cmoro-deusto/docker-play/issues/4
# Define user home. Activator will store ivy2 and sbt caches on /home/play/Code volume
RUN echo "export _JAVA_OPTIONS='-Duser.home=/home/play/Code'" >> /home/play/.bashrc

# Change user, launch bash
USER play
WORKDIR /home/play
CMD ["/bin/bash"]

# Expose Code volume and play ports 9000 default 9999 debug 8888 activator ui
VOLUME "/home/play/Code"
EXPOSE 9000
EXPOSE 9999
EXPOSE 8888
WORKDIR /home/play/Code
