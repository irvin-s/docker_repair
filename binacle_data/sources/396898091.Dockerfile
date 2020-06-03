# Takipi
FROM ubuntu:15.10

MAINTAINER Chen Harel "https://github.com/chook"

# Install JDK8
RUN apt-get update
RUN apt-get install -y wget openjdk-8-jdk

# Needed for Ubuntu 15.10, October 2015
RUN update-ca-certificates -f

# Get Takipi for containers 
RUN wget -O - -o /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

# Setup Takipi key and name
RUN /opt/takipi/etc/takipi-setup-machine-name server-name

# Getting Java tester
RUN wget https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar -O scala-boom.jar

# Running a java process with Takipi
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
