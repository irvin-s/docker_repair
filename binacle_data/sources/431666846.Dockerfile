# Dockerfile to add sbt to a debian based java 8 image
FROM java:openjdk-8-jre
RUN apt-get update
RUN apt-get -y install curl unzip openssh-client
RUN cd /usr/local/bin ; curl https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.7/sbt-launch.jar -o sbt-launch.jar
RUN cd /usr/local/bin ; echo "#!/bin/sh" > sbt
RUN cd /usr/local/bin ; echo 'SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"' >> sbt
RUN cd /usr/local/bin ; echo 'java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"' >> sbt
RUN cd /usr/local/bin ; chmod a+rx sbt
# eof

