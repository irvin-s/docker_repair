FROM projectriff/shell-function-invoker:latest
ARG FUNCTION_URI="/greeting.sh"
ADD greeting.sh /
ENV FUNCTION_URI $FUNCTION_URI
