FROM williamyeh/docker-java7  
  
MAINTAINER Dexter Tad-y <dtady@cpan.org>  
  
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle  
  
ADD sbt /usr/bin/  
ADD sbt-launch.jar /usr/bin/  
  
RUN /usr/bin/sbt  
  
ADD scala /usr/bin/  

