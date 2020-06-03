FROM java:8

RUN mkdir /jmeter \
    && cd /jmeter/ \
    && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-3.3.tgz \
    && tar -xvzf apache-jmeter-3.3.tgz \
    && rm apache-jmeter-3.3.tgz

ENV JMETER_HOME /jmeter/apache-jmeter-3.3/

# Add Jmeter to the Path
ENV PATH $JMETER_HOME/bin:$PATH
