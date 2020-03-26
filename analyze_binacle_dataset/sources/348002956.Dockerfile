FROM busybox:latest

RUN mkdir /workspace
COPY helloworld /workspace/helloworld
RUN chmod -R a+rw /workspace
