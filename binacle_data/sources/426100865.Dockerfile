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

# Installation, tests and compilation
RUN wget www.scala-lang.org/files/archive/scala-2.11.2.deb && \
    dpkg -i scala-2.11.2.deb && \
    rm scala-2.11.2.deb && \
    wget https://dl.bintray.com/sbt/debian/sbt-0.13.6.deb && \
    dpkg -i sbt-0.13.6.deb && \
    rm sbt-0.13.6.deb && \
    apt-get -y install nodejs npm && \
    cd /opt/ && \
    apt-get -y install git && \
    git clone https://github.com/TechnologyConversations/TechnologyConversationsBdd.git bdd && \
    cd /opt/bdd/ && \
    npm install -g grunt-cli && \
    npm install -g bower && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    bower install --allow-root && \
    npm test && \
    sbt ++2.10.3 test && \
    sbt "test:run-main models.jbehave.JBehaveRunnerAssistant --story_path data/stories/tcbdd/**/*.story -P browser=phantomjs -P url=http://localhost:1234 -P widthHeight=1024,768 --composites_path composites/TcBddComposites.groovy" && \
    sbt stage && \
    rm -rf .buildpacks .git .gitignore .travis.yml Gruntfile.js Procfile bower.json build.sbt gulpfile.js && \
    rm -rf package.json phantomjsdriver.log scalastyle-config.xml system.properties && \
    rm -rf app bower_components composites/TestViewComposites.groovy conf dist docker less node_modules logs/* && \
    rm -rf project public/jbehave/[1-2]* scripts test && \
    rm -rf target/resolution-cache target/scala-2.10 target/specs2-reports target/streams target/test-reports target/universal/tmp && \
    dpkg -r scala && \
    dpkg -r git && \
    dpkg -r sbt && \
    dpkg -r npm && \
    apt-get -y autoremove && \
    apt-get clean all && \
    rm -rf /root/.ivy2 /root/.cache /root/.npm /root/.sbt

# Run
RUN mkdir -p /opt/bdd/target/universal/stage/build/reports/tests/
RUN mkdir -p /opt/bdd/build/reports/tests/
WORKDIR /opt/bdd/
EXPOSE 9000
CMD ["target/universal/stage/bin/tcbdd", "-Dcom.technologyconversations.bdd.steps.WebSteps.browser=phantomjs"]