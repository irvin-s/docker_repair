  # more info https://registry.hub.docker.com/_/tomcat/
  FROM tomcat:7.0.63-jre8

  ADD ./cloudopting.war /usr/local/tomcat/webapps/cloudopting.war
