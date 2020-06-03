FROM java:8-jdk

MAINTAINER Brian Byers <bbyers@pivotal.io>

ENV HOME /root

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-4.2.1-bin.zip
RUN unzip gradle-4.2.1-bin.zip
RUN mv gradle-4.2.1 /opt/
RUN rm gradle-4.2.1-bin.zip

# Environment variables
ENV GRADLE_HOME /opt/gradle-4.2.1
ENV PATH $PATH:$GRADLE_HOME/bin
