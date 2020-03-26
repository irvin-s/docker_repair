# Takipi
#
# Installs Java, Takipi and runs Takipi with a Java tester

# Takipi
FROM ubuntu:12.04

MAINTAINER Chen Harel "https://github.com/chook"

# Install JDK
RUN apt-get update
RUN apt-get install -y wget openjdk-6-jdk

# Takipi installation
RUN wget -O - -o /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

# Getting Java tester
RUN wget https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar

# Connecting the Takipi agent to a Java process
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
