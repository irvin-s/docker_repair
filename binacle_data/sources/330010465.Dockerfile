FROM projectriff/command-function-invoker:0.0.6
ARG FUNCTION_URI="/echo-shell.sh"
ADD echo-shell.sh /
ENV FUNCTION_URI $FUNCTION_URI
