FROM cfregly/tomcat 
MAINTAINER Chris Fregly "chris@fregly.com"

# copy the war to the tomcat directory
ADD https://netflixoss.ci.cloudbees.com/job/eureka-master/lastSuccessfulBuild/artifact/eureka-server/build/libs/eureka-server-1.1.121-SNAPSHOT.war /var/lib/tomcat7/webapps/eureka.war
