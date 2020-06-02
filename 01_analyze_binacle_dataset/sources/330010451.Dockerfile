FROM projectriff/java-function-invoker:0.0.6
ARG FUNCTION_JAR=/functions/echo-1.0.0.jar
ARG FUNCTION_HANDLER=functions.Echo
ADD target/echo-1.0.0.jar $FUNCTION_JAR
ENV FUNCTION_URI file://${FUNCTION_JAR}?handler=${FUNCTION_HANDLER}
