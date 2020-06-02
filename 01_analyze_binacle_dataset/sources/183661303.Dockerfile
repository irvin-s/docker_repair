FROM jeanblanchard/java:8

RUN apk --update add bash curl

ENV TEST_DRIVE_DIR=/data/gremthon-test-drive
RUN mkdir -p "$TEST_DRIVE_DIR"

# set up jython
RUN curl -L "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar" -o "$TEST_DRIVE_DIR/jython-installer.jar" && \
    java -jar "$TEST_DRIVE_DIR/jython-installer.jar" -s -d "$TEST_DRIVE_DIR/jython-2.7.0"

# set up titan
ENV GREMTHON_JAR_DIRS="$TEST_DRIVE_DIR/titan-0.5.3-hadoop2/lib"
RUN curl -L "http://s3.thinkaurelius.com/downloads/titan/titan-0.5.3-hadoop2.zip" -o "$TEST_DRIVE_DIR/titan-0.5.3-hadoop2.zip" && \
    unzip -o "$TEST_DRIVE_DIR/titan-0.5.3-hadoop2.zip" -d "$TEST_DRIVE_DIR" && \
    curl -L "http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar" -o "$GREMTHON_JAR_DIRS/jython-standalone-2.7.0.jar" && \
    curl -L "http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.0.5.4/snappy-java-1.0.5.4.jar" -o "$GREMTHON_JAR_DIRS/snappy-java-1.0.5-M3.jar"

ADD rexster-test-drive.xml "$TEST_DRIVE_DIR/titan-0.5.3-hadoop2/conf/rexster-cassandra-es.xml"
ADD load_example_graph.py "$TEST_DRIVE_DIR/load_example_graph.py"
ADD doctors-consumers-graph.json "$TEST_DRIVE_DIR/doctors-consumers-graph.json"
ADD run.sh "$TEST_DRIVE_DIR/run.sh"

RUN curl -L "https://github.com/pokitdok/gremlin-python/releases/download/0.2.1/gremlin-python-0.2.1.jar" -o "$GREMTHON_JAR_DIRS/gremlin-python-0.2.1.jar"

VOLUME "$TEST_DRIVE_DIR"

EXPOSE 8182 8184
CMD /data/gremthon-test-drive/run.sh