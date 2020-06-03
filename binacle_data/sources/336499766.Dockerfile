# taken from https://github.com/mozart-analytics/grails-docker/blob/master/grails-3/Dockerfile
FROM java:8

# Set customizable env vars defaults.
# Set Grails version (default: 3.2.8; min: 3.0.0; max: 3.2.8).
ARG GRAILS_VERSION=3.3.1

# Install Grails
WORKDIR /usr/lib/jvm
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip && \
    ln -s grails-$GRAILS_VERSION grails
ENV GRAILS_HOME /usr/lib/jvm/grails
ENV PATH $GRAILS_HOME/bin:$PATH

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN grails war


FROM tomcat:8.5.3-jre8

RUN rm -rf /usr/local/tomcat/conf/ & \
    rm -rf /usr/local/tomcat/webapps/
    
COPY --from=0 /app/build/libs/bucket-0.1.war /usr/local/tomcat/webapps/ROOT.war
COPY tomcat-conf/ /usr/local/tomcat/conf/
COPY setenv.sh /usr/local/tomcat/bin/setenv.sh

CMD ["catalina.sh", "jpda", "run"]