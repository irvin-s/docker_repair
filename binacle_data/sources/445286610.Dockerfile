FROM cfregly/tomcat 
MAINTAINER Chris Fregly "chris@fregly.com"

# copy the war to the tomcat directory
ADD https://cfregly.ci.cloudbees.com/job/fluxcapacitor/lastSuccessfulBuild/artifact/flux-middletier/build/libs/flux-middletier-0.1.0-SNAPSHOT.war /var/lib/tomcat7/webapps/flux-middletier.war
