# Version: 0.1
FROM ubuntu:14.04
MAINTAINER Viktor Farcic "viktor@farcic.com"

# General
RUN apt-get update
RUN apt-get -y install --no-install-recommends wget unzip openjdk-7-jdk && \
    apt-get -y autoremove && \
    apt-get clean all

# Browsers
RUN apt-get -y install phantomjs && \
    apt-get -y autoremove && \
    apt-get clean all

RUN wget www.scala-lang.org/files/archive/scala-2.11.2.deb
RUN dpkg -i scala-2.11.2.deb
RUN wget https://dl.bintray.com/sbt/debian/sbt-0.13.6.deb
RUN dpkg -i sbt-0.13.6.deb
RUN apt-get -y install nodejs npm
WORKDIR /opt/
RUN apt-get -y install git
RUN git clone https://github.com/TechnologyConversations/TechnologyConversationsBdd.git
WORKDIR /opt/TechnologyConversationsBdd/
RUN npm install -g grunt-cli
RUN npm install -g bower
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN bower install --allow-root
RUN npm test
RUN sbt ++2.10.3 test
RUN sbt "test:run-main models.jbehave.JBehaveRunnerAssistant --story_path data/stories/tcbdd/**/*.story -P browser=phantomjs -P url=http://localhost:1234 -P widthHeight=1024,768 --composites_path composites/TcBddComposites.groovy"
RUN sbt stage

# Run
RUN mkdir -p /opt/TechnologyConversationsBdd/target/universal/stage/build/reports/tests/
RUN mkdir -p /opt/TechnologyConversationsBdd/build/reports/tests/
WORKDIR /opt/TechnologyConversationsBdd/
EXPOSE 9000
CMD ["target/universal/stage/bin/tcbdd -Dcom.technologyconversations.bdd.steps.WebSteps.browser=phantomjs"]
