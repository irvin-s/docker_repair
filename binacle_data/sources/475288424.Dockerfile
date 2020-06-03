FROM jeanblanchard/java
MAINTAINER Jose Armesto <jose@armesto.net>

EXPOSE 8000
CMD ["java", "-jar", "/code/hello-world-1.0-SNAPSHOT.jar"]
ADD ./build/libs /code