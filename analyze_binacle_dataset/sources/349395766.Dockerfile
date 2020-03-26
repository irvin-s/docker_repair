FROM java:openjdk-8-jdk
WORKDIR /usr/registrolivre
COPY ./ .
RUN ./gradlew compileJava processResources classes findMainClass
CMD ./gradlew bootRun
