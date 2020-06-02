FROM java  
MAINTAINER Frederik Hahne <frederik.hahne@gmail.com>  
  
ADD target/vertx-publisher-0.0.1-fat.jar /  
  
CMD ["java", "-jar", "/vertx-publisher-0.0.1-fat.jar"]  
  
EXPOSE 5702

