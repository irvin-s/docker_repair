# This is a reference Dockerfile prepared for your service and it contains all the commands
# which can be used by Docker to build images automatically.
#
# To build an image with the Docker CLI-tool, execute the following command in this directory:
#
#     docker build -t {{artifactId}} .
#
# To run it locally execute the following command:
#
#     docker run -it --rm -p 8080:8080 {{artifactId}}
#
# For more information see:
# https://docs.docker.com/engine/reference/run/
#
# Note: before building and running the image make sure that you have built the maven artifact and it is present in the target folder.
#
# This image is based on the tomcat:jre8-alpine image which contains Tomcat 8, OpenJDK JRE 8 installed on Alpine Linux.
# For more information see:
# https://hub.docker.com/_/tomcat/
#
FROM tomcat:jre8-alpine

# It is recommended that you pass the maintainer argument when building the image:
ARG maintainer=undefined

ARG app={{artifactId}}

# You can also set the JAVA VM Options by passing the 'JAVA_OPTS' argument or you can use the pre-defined default values.
ARG JAVA_OPTS="-Xms400M -Xmx1024M"

LABEL maintainer=$maintainer app=$app

RUN rm -rf /usr/local/tomcat/webapps/*
ADD ./target/{{artifactId}}.war /usr/local/tomcat/webapps/ROOT.war

ENV JAVA_OPTS=$JAVA_OPTS
EXPOSE 8080:8080
