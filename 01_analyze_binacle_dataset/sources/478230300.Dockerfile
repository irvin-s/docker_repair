FROM berlius/artificial-intelligence-gpu

MAINTAINER berlius <berlius52@yahoo.com>

# Update java
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk 

# Update-ca-certificates
RUN update-ca-certificates -f 

# Update environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/libtools.jar:$CLASSPATH \
    PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH

WORKDIR "/root"
CMD ["/bin/bash"]
