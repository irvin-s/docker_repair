FROM centos:centos6
MAINTAINER bdelacretaz@apache.org

RUN yum clean all
RUN yum -y update
RUN yum install -y java-1.7.0-openjdk-devel.x86_64 tar subversion

ADD fsroot /

# Install Maven
RUN mkdir -p /lib/maven
WORKDIR /lib/maven
RUN curl http://mirror.switch.ch/mirror/apache/dist/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz | tar zxvf -
ENV PATH $PATH:/lib/maven/apache-maven-3.2.3/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.65.x86_64

# Build any SNAPSHOTs required by our Crankstart file 
# (at a specific svn revision, to be deterministic)
ENV SLING_REV 1628181

WORKDIR /bundles
RUN svn export -r $SLING_REV https://svn.apache.org/repos/asf/sling/trunk/contrib/launchpad/karaf/org.apache.sling.launchpad.karaf
WORKDIR /bundles/org.apache.sling.launchpad.karaf
RUN mvn clean install

WORKDIR /bundles
RUN svn export -r $SLING_REV https://svn.apache.org/repos/asf/sling/trunk/bundles/jcr/base
WORKDIR /bundles/base
RUN mvn clean install

WORKDIR /bundles
RUN svn export -r $SLING_REV https://svn.apache.org/repos/asf/sling/trunk/bundles/jcr/oak-server
WORKDIR /bundles/oak-server
RUN mvn clean install

WORKDIR /bundles/sling-etcd
RUN mvn clean install

# Create the Sling state during Docker image build
# (TODO remove Sling id file?)
RUN /bin/bash /start.sh true

# Run Sling from the state created during image build
CMD /bin/bash /start.sh false
