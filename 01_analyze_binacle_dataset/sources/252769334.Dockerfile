FROM openjdk:8-jdk as builder  
  
RUN apt-get -qq update && apt-get install -y \  
git  
  
RUN mkdir /tmp/csv2db  
WORKDIR /tmp/csv2db  
COPY . .  
RUN ./gradlew clean build  
  
FROM openjdk:8-jre  
  
RUN mkdir -p /usr/share/csv2db  
COPY \--from=builder /tmp/csv2db/build/libs/* /usr/share/csv2db/  
  
ENTRYPOINT ["/usr/share/csv2db/run.sh"]  
  
CMD []%  

