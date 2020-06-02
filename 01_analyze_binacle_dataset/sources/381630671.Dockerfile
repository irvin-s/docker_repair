# VERSION:        1.1.7
# DOCKER-VERSION: 1.3.1
# AUTHOR:         ... <..@..>
# DESCRIPTION:    Critter is a http proxy server for simulating connectivity and transport problems when sending http requests.
# TO_BUILD:       docker build --rm -t critter .
# TO_RUN:         docker run --name critter -P critter
# TO_PUSH:        docker push <hub or user>/critter[:tag]
#
# Run `mvn clean package` before trying to build this image
#

FROM            maxexcloo/java:latest

ADD             critter-*-pkg.tar.gz   /opt/critter
RUN             chmod a+x -R /opt/critter/bin

EXPOSE          8888 8877
CMD             ["/opt/critter/bin/start-container.sh","--no-daemon"]
