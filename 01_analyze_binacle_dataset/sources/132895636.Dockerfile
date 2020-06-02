FROM ubuntu

# basic stuff
RUN apt-get install -y git curl

# install java
RUN apt-get install -y openjdk-6-jdk

# install scala
RUN curl -o /tmp/scala-2.10.2.tgz http://www.scala-lang.org/files/archive/scala-2.10.2.tgz
RUN tar xzf /tmp/scala-2.10.2.tgz -C /usr/share/
RUN ln -s /usr/share/scala-2.10.2 /usr/share/scala

# symlink scala binary to /usr/bin
RUN for i in scala scalc fsc scaladoc scalap; do ln -s /usr/share/scala/bin/${i} /usr/bin/${i}; done

# install sbt
RUN curl -o /tmp/sbt.deb  http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.4/sbt.deb
RUN dpkg -i /tmp/sbt.deb
