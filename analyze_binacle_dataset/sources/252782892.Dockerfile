FROM java:8  
  
ADD build/libs/dropwizard71-fat-1.0.jar /data/dropwizard71-fat-1.0.jar  
ADD prod.yml /data/prod.yml  
  
CMD java -jar /data/dropwizard71-fat-1.0.jar server /data/prod.yml  
  
EXPOSE 8080  
EXPOSE 8081

