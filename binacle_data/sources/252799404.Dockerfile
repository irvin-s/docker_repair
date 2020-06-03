FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/tragicallylovely.jar /tragicallylovely.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /tragicallylovely.jar" ]

