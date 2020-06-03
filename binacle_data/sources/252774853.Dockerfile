FROM mlist/grails:2.5.3  
MAINTAINER Markus List <mlist@mpi-inf.mpg.de>  
  
# Create App Directory  
COPY . /app  
WORKDIR /app  
  
# Setup Grails paths  
ENV GRAILS_HOME /usr/lib/jvm/grails  
ENV PATH $GRAILS_HOME/bin:$PATH  
  
# Setup Java paths  
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64  
ENV PATH $JAVA_HOME/bin:$PATH  
  
# Compile kpm core and grails app  
RUN cd keypathwayminer-core/ && \  
apt-get update && \  
apt-get install -y maven && \  
mvn install && \  
cd .. && \  
grails refresh-dependencies && \  
grails compile  
  
# Expose port to outside world  
EXPOSE 8080  
# Start grails app  
ENTRYPOINT ["/sbin/my_init", "grails"]  
CMD ["prod", "run-app"]  

