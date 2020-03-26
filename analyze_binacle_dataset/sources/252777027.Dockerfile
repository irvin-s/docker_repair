FROM cenote/trusty-java8  
  
# JasperStarter Maven dependencies  
# Download (almost) all dependencies for building JasperStarter to  
# speed up Buildtime and save Bitbucket Pipeline minutes.  
  
## A simple solution could be this but it gets not all.  
#ADD https://bitbucket.org/cenote/jasperstarter/raw/master/pom.xml .  
#RUN mvn dependency:go-offline && rm pom.xml  
  
## this needs a git checkout of Jasperstarter:  
#RUN mvn dependency:analyze-report  
  
## if we need a checkout anyway, just make a full release build.  
RUN cd /tmp && \  
git clone https://bitbucket.org/cenote/jasperstarter.git && \  
cd jasperstarter && \  
mvn package -P release,windows-setup && \  
rm -R /tmp/jasperstarter  

