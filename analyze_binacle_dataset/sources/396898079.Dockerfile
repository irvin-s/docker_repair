# Takipi
#
# Installs Java, Takipi and runs Takipi with a Java tester

FROM centos:7

MAINTAINER Chen Harel "https://github.com/chook"

RUN yum install -y java-1.8.0-openjdk.x86_64

# Takipi installation
RUN curl -Ls /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

# Getting Java tester
RUN curl -o scala-boom.jar -L https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar

# Connecting the Takipi agent to a Java process
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
