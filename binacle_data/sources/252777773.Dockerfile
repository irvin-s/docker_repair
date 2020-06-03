FROM java:8  
MAINTAINER Anuroop Thomas <anuroopbthomas@gmail.com>  
  
EXPOSE 8080:8080  
ADD /target/springdocker-demo.jar springdocker-demo.jar  
ENTRYPOINT ["java","-jar","springdocker-demo.jar"]

