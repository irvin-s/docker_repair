

FROM openjdk:8
ADD ./inference-server/target/scala-2.11/inference-server-assembly-0.1.0-SNAPSHOT.jar /usr/local/bin/inference-server-assembly-0.1.0-SNAPSHOT.jar
ADD ./serve /usr/local/bin/serve
#ADD ./model/model.zip /mnt/model.zip
RUN chmod a+x /usr/local/bin/serve

