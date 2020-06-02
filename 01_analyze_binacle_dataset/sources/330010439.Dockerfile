FROM projectriff/java-function-invoker:latest
ARG FUNCTION_JAR=/functions/counter-1.0.0-jar-with-dependencies.jar
ARG FUNCTION_CLASS=functions.Counter
ADD target/counter-1.0.0-jar-with-dependencies.jar $FUNCTION_JAR
ENV FUNCTION_URI file://${FUNCTION_JAR}?handler=${FUNCTION_CLASS}
