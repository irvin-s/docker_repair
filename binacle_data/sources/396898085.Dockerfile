# Takipi
#
# Installs and runs Takipi with a Java tester

# Start with a working oracle jdk 7 image
FROM java:7

MAINTAINER Chen Harel "https://github.com/chook"

# Installing Takipi via apt-get and setting up key
RUN wget -O - -o /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

RUN /opt/takipi/etc/takipi-setup-machine-name server-name

# Getting Java tester
RUN wget https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar -O scala-boom.jar

EXPOSE 80

# Running Java process with Takipi agent
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
