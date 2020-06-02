# A Logger Seed for Scala Apps  
# Lewis M.  
# pull automated build:  
# >> docker pull animatedlew/logger  
# build image:  
# >> docker build -t animatedlew/logger.  
# inspect log:  
# >> docker run -it --rm animatedlew/logger cat /var/log/cota/helix/debug.log  
FROM hseeberger/scala-sbt:latest  
  
ENV SBT_OPTS="-Xms1G -Xmx4G -Xss1M"  
# comment this line out to test default logback settings  
ENV LOGBACK_FILE="-Dlogback.configurationFile=/opt/cota/helix/logback.xml"  
RUN mkdir -p /var/log/cota/helix /root/helix /opt/cota/helix  
RUN touch /var/log/cota/helix/debug.log  
  
# move logback conf to a global location  
COPY src/main/resources/logback.xml /opt/cota/helix  
  
WORKDIR /root/helix  
  
COPY . /root/helix  
RUN sbt assembly  
  
# pass in logback ref to jvm runtime  
RUN java $SBT_OPTS $LOGBACK_FILE -jar target/scala-2.12/log.jar  
RUN cat /var/log/cota/helix/debug.log  

