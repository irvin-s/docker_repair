FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/yikyack.jar /yikyack.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /yikyack.jar" ]

