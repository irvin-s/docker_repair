FROM registry.access.redhat.com/openshift3/jenkins-slave-maven-rhel7

USER 0

ENV PATH=$HOME/.local/bin/:$PATH \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
   
ENV SUMMARY="Jenkins maven slave with Android SDK tools for Android build and test." \
    DESCRIPTION="Jenkins maven slave with Android SDK tools for Android build and test."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Jenkins-Pipeline-Android" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,jenkins-jnlp" \
      release="1"

RUN yum install -y --setopt=tsflags=nodocs wget curl openssl&& \
    rpm -V wget curl openssl && \
    yum clean all -y

ENV OPENSHIFT_JENKINS_JVM_ARCH=x86_64
ENV ANDROID_HOME=/opt/android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.i386/jre 

# Create an ANDROID_HOME and install the SDK tools
RUN cd /tmp && \
    curl -s https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O && \
    mkdir -p /opt/android && \
    unzip -q -d /opt/android sdk-tools-linux-3859397.zip && \
    rm -f sdk-tools-linux-3859397.zip && \
    cd -

# Install the build tools, agree to the licensing.
RUN mkdir -p /root/.android/ && \
    touch /root/.android/repositories.cfg && \
    /opt/android/tools/bin/sdkmanager --update && \
    yes | /opt/android/tools/bin/sdkmanager --licenses

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME
    
RUN chmod -R 777 /opt/android

RUN find / | grep tools.jar

EXPOSE 8080

USER 1001
