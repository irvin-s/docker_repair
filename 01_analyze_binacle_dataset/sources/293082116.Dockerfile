#FROM isuper/java-oracle:jdk_8
FROM store/oracle/serverjre:8

ENV GIT_URL https://github.com/dantheman213/java-hello-world-maven
ENV APP_PORT 8080

ENV APP_HOME .
ENV APP_STARTUP "com.myorganization.app.Main"
ENV ARTIFACT_ID myapp
ENV VERSION "1.0"

ENV JUST_RUN="N"

# indicates whether dependencies are 
# JAR = included in a single jar $ARTIFACT_ID-$VERSION-jar-with-dependencies.jar
# LIBS = included in separated jar files in directory /target/dependency; the application jar is then called  $ARTIFACT_ID-$VERSION.jar
ENV MAVEN_DEPENDENCIES="JAR"


# installation of Apache Maven
# Install Maven


ARG MAVEN_VERSION=3.5.0
ARG USER_HOME_DIR="/root"
ENV MAVEN_VERSION 3.5.0
ENV USER_HOME_DIR "/root"

#RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
#  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
#    | tar -xzC /usr/share/maven --strip-components=1 \
#  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

#RUN mvn -version

# install GIT client
# adds a layer of 700 MB!
RUN yum -y install git
RUN git --version

RUN yum -y install tar

#install Maven 3
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
    && curl -O http://apache.mirror1.spango.com/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz 
RUN tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# copy docker-work
COPY ./docker-work /code

WORKDIR /code

#RUN chown -R app:app /code/*
RUN chmod +x /code/bootstrap.sh

# initialize Maven Repository
RUN ./bootstrap.sh
# then remove anything created in directory app
WORKDIR /code
RUN rm -rf app

ENTRYPOINT ["/code/bootstrap.sh"]
#ENTRYPOINT ["/bin/bash.sh"]
