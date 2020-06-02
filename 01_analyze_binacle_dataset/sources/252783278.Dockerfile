FROM maven:3.2-jdk-8-onbuild  
CMD ["/usr/bin/mvn","exec:java"]  
EXPOSE 80

