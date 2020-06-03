FROM 1science/sbt  
  
WORKDIR /app  
ADD project/build.properties project/*.sbt /app/project/  
RUN sbt "; update ; compile"  
  
ADD project/*.scala *.sbt /app/project/  
RUN sbt "; update ; compile"  
  
ADD . /app/  
RUN sbt stage  
  
CMD ["/app/server/target/universal/stage/bin/server"]  
EXPOSE 8080  

