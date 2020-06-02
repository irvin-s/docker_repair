# Build the executable .jar  
FROM openjdk:8 AS build  
  
WORKDIR /opt/memegrid  
  
COPY build.gradle gradlew ./  
COPY gradle ./gradle  
COPY src ./src  
  
RUN ./gradlew shadowJar  
  
# Run the built .jar  
FROM openjdk:8  
WORKDIR /opt/memegrid  
  
COPY \--from=build /opt/memegrid/build/libs .  
  
ENTRYPOINT ["java", "-jar", "meme-grid.jar"]  

