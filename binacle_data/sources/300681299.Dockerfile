FROM selenium/standalone-chrome

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get -y install openjdk-8-jdk && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV CHROME_DRIVER="/usr/bin/chromedriver"

COPY . /cals-api
WORKDIR /cals-api

CMD ./gradlew clean miniIntegrationTest --info
