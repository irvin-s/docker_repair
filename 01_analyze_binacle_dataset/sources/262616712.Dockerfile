FROM thonatos/openjdk-tomcat-maven:jdk8-maven3

ENV JAVA_OPTS="-Dspring.profiles.active=product"

# https://github.com/hengyunabc/xdiamond
ENV XDIAMOND_VERSION="1.0.4"

RUN apk add --update openssl

RUN mkdir -p /app \
    && wget -O /tmp/app.zip "http://search.maven.org/remotecontent?filepath=io/github/hengyunabc/xdiamond/xdiamond-server/$XDIAMOND_VERSION/xdiamond-server-$XDIAMOND_VERSION.war" \
    && unzip /tmp/app.zip -d /app/ \
    && rm -rf /tmp/* \
    && rm -rf /usr/local/tomcat/webapps/ROOT \
    && mv /app /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

EXPOSE 5678