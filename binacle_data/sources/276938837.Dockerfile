FROM jmeter-base

WORKDIR $JMETER_HOME
# Ports to be exposed from the container for JMeter Master
RUN mkdir scripts

EXPOSE 60000