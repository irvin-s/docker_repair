FROM verilumaci/maven-3.3.9
EXPOSE 8080

ADD code /code/

RUN mvn package -f /code/pom.xml && mv /code/target/*swarm.jar /code/target/app.jar
#ADD /target/*swarm.jar /usr/src/myapp/app.jar

ENTRYPOINT ["java","-jar","/code/target/app.jar"]
CMD [""]
