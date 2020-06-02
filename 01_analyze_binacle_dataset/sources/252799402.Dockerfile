FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/summerchase.jar /summerchase.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /summerchase.jar" ]

