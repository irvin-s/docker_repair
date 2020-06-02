FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/jamaicatalina.jar /jamaicatalina.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /jamaicatalina.jar" ]

