FROM consol/ubuntu-xfce-vnc

USER root
# prepare the docker to be able to run gradle and the selenium interface framework
RUN apt update
RUN apt-get install -y curl vim watch openjdk-8-jdk unzip

# Copy the selenium content to /seeny
COPY . /seeny

WORKDIR /seeny

RUN curl -L https://services.gradle.org/distributions/gradle-3.3-bin.zip -o gradle-3.3-bin.zip
RUN unzip gradle-3.3-bin.zip
ENV GRADLE_HOME=/seeny/gradle-3.3
ENV PATH=$PATH:$GRADLE_HOME/bin

# setting default value to be overwritten by env variable with script name to be executed
ENV SCRIPTNAME=geeny.io 

# Build current project
RUN gradle build

CMD java -jar build/libs/seeny-1.6.1-all.jar -w $SCRIPTNAME -pp-width 140
