FROM dgageot/java8

ADD dropwizad-app-1.0-SNAPSHOT.jar dropwizad-app-1.0-SNAPSHOT.jar

ADD config.yml config.yml

CMD java -jar dropwizad-app-1.0-SNAPSHOT.jar server config.yml

EXPOSE 8080