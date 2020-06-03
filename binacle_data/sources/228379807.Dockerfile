FROM 1science/sbt

# install gradle
ENV GRADLE_VERSION 2.9
ENV PATH ${PATH}:/usr/local/gradle-$GRADLE_VERSION/bin
WORKDIR /usr/local
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
RUN unzip gradle-$GRADLE_VERSION-bin.zip
RUN rm gradle-$GRADLE_VERSION-bin.zip

ADD . /app
WORKDIR /app

# build stanford corenlp
WORKDIR lib/CoreNLP
RUN gradle build

# build stanford corenlp server
WORKDIR /app
RUN sbt compile

# run stanford corenlp server
EXPOSE 8081 9990
CMD ["sbt", "run"]
