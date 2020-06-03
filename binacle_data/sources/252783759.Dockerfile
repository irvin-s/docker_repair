FROM tomcat:latest  
MAINTAINER martin scharm  
  
  
COPY src /srv/src  
COPY pom.xml /srv/pom.xml  
WORKDIR /srv/  
  
# install dependencies, compile the code, and get rid of dependencies...  
RUN deps="maven openjdk-${JAVA_VERSION%%[-~bu]*}-jdk=$JAVA_DEBIAN_VERSION" \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $deps \  
&& mvn package \  
&& cp target/*war /usr/local/tomcat/webapps/ROOT.war \  
&& mvn clean \  
&& rm -rf /usr/local/tomcat/webapps/ROOT \  
&& rm -rf /root/.m2 /usr/share/doc \  
&& apt-get purge -y --auto-remove maven \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  

