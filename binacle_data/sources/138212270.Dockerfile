#
# Dropship Dockerfile
#
# https://github.com/zulily/dropship
#

# Pull base image.
FROM dockerfile/java

RUN mkdir -p /usr/local/dropship
RUN curl -o /usr/local/dropship/dropship.jar http://repo1.maven.org/maven2/com/zulily/dropship/dropship/1.1/dropship-1.1.jar

ENTRYPOINT ["java","-jar","/usr/local/dropship/dropship.jar"]
