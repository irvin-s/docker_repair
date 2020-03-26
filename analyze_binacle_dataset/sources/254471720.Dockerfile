FROM openjdk:8-jre-alpine
COPY target/executor-0.0.1-alpha1-SNAPSHOT-jar-with-dependencies.jar /main.jar
CMD java -classpath /main.jar io.metaparticle.containerlib.elector.Main
