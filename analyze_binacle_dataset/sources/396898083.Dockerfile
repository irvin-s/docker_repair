# Takipi
#
# Installs and runs Takipi with a Java tester

# Start with a working oracle centos openjdk 7 image
FROM tcnksm/centos-java

MAINTAINER Chen Harel "https://github.com/chook"

# Takipi installation
RUN curl -Ls /dev/null http://get.takipi.com/takipi-t4c-installer | \
	bash /dev/stdin -i --sk=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1

RUN /opt/takipi/etc/takipi-setup-machine-name server-name

# Getting Java tester
RUN curl -o scala-boom.jar -L https://s3.amazonaws.com/app-takipi-com/chen/scala-boom.jar

EXPOSE 80

# Running Java process with Takipi agent
CMD java -agentlib:TakipiAgent -jar scala-boom.jar
