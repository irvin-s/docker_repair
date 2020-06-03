FROM mattdm/fedora:f20
MAINTAINER vnguyen@redhat.com

RUN yum install -y unzip java-1.7.0-openjdk-devel nginx wget
RUN curl -L -o /tmp/gradle.zip http://services.gradle.org/distributions/gradle-1.11-bin.zip
RUN unzip -d /opt /tmp/gradle.zip
RUN rm /tmp/gradle.zip
RUN ln -s /opt/gradle-1.11/bin/gradle /usr/bin/gradle
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk
RUN curl -L -o jontests.zip https://github.com/RedHatQE/jon-tests/archive/master.zip
RUN unzip jontests.zip
RUN rm jontests.zip
ADD clitest-start /usr/bin/clitest-start
ADD nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT ["/usr/bin/clitest-start"]


