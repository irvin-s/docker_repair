FROM dockerfile/java:oracle-java8
RUN locale-gen pl_PL.UTF-8
ENV LANG pl_PL.UTF-8
RUN mkdir -p /opt/ctrl-pkw
ADD build/distributions/ctrl-pkw.tgz /opt/
WORKDIR /opt/ctrl-pkw
CMD bin/ctrl-pkw
