FROM ubuntu:trusty

# Make sure the package repository is up to date.
RUN apt-get install -y software-properties-common
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install Java.
RUN \
 echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
 add-apt-repository -y ppa:webupd8team/java && \
 apt-get update && \
 apt-get install -y oracle-java8-installer && \
 rm -rf /var/lib/apt/lists/* && \
 rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Add user jenkins to the image
RUN useradd -m jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]