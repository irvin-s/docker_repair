FROM projectriff/node-function-invoker:0.0.8
ENV FUNCTION_URI /functions/echo-node.js
ADD echo-node.js ${FUNCTION_URI}
