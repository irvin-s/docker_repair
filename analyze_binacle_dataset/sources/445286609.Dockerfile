FROM cfregly/tomcat 
MAINTAINER Chris Fregly "chris@fregly.com"

ADD https://cfregly.ci.cloudbees.com/job/fluxcapacitor/lastSuccessfulBuild/artifact/flux-edge/build/libs/flux-edge-0.1.0-SNAPSHOT.war /var/lib/tomcat7/webapps/flux-edge.war
