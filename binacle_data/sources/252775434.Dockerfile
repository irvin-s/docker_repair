# Compile Grimoire  
FROM openjdk:8-jdk as compiler  
WORKDIR /usr/bin/app  
COPY . .  
RUN ./gradlew clean build uberjar  
  
# Extract JAR  
FROM openjdk:8-jre  
WORKDIR /usr/bin/app  
COPY \--from=compiler /usr/bin/app/build/libs/Grimoire-2.0.jar .  
  
# Run Grimoire  
CMD java -Xmx1536M -Xms1G -jar Grimoire-2.0.jar

