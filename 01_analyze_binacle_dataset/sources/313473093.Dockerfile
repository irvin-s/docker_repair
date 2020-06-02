FROM jetty:9.4.5-alpine
MAINTAINER Alex Pomosov
ADD ./build/libs/*.war /var/lib/jetty/webapps/ROOT.war
EXPOSE 8080
