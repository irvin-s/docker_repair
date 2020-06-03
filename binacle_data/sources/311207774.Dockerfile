FROM ubuntu:16.04

# add-apt-repository to setup Oracle JDK
# sudo for user switching
# curl for downloads
RUN apt-get update && \
    apt-get --assume-yes --quiet install software-properties-common sudo curl

# Install Oracle JDK 8.
RUN add-apt-repository ppa:webupd8team/java && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get update && \
    apt-get --assume-yes --quiet install oracle-java8-installer && \
    java -version

# Build gradle-profiler
RUN mkdir -p /opt/projects && \
    cd /opt/projects && \
    apt-get --assume-yes --quiet install git && \
    git clone https://github.com/gradle/gradle-profiler.git gradle-profiler && \
    cd gradle-profiler && \
    git checkout 7b9ca3d93a76ee107f26534271f6f398360d4d03 && \
    ./gradlew installDist --stacktrace

# Entrypoint script will allow us run as non-root in the container.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
