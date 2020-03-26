#FROM java:8  
FROM isuper/java-oracle:jre_8  
VOLUME /tmp  
ADD ./build/libs/sabbat.api-gateway.jar /app.jar  
ADD ./run.sh /run.sh  
RUN touch /app.jar  
RUN touch /run.sh  
ENTRYPOINT ["/bin/bash", "-ex", "run.sh"]

