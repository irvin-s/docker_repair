FROM dckreg:5000/spark:1.6.3

ENV SBT_VERSION     0.13.13
ENV SBT_HOME        /opt/sbt  
ENV PATH            $PATH:$SBT_HOME/bin

ADD https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz sbt-$SBT_VERSION.tgz

RUN tar xvf sbt-$SBT_VERSION.tgz

run mv sbt /opt/sbt

RUN rm sbt-$SBT_VERSION.tgz 

RUN mkdir /root/project

COPY sbtfile /root/build.sbt
COPY plugins.sbt /root/project/plugins.sbt

WORKDIR /root

RUN sbt 

RUN echo "console" | sbt 

RUN apt install -y vim
