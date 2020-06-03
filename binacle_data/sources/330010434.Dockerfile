FROM projectriff/shell-function-invoker:latest
ARG FUNCTION_URI="/timestamp.sh"
ADD timestamp.sh /
ENV FUNCTION_URI $FUNCTION_URI
