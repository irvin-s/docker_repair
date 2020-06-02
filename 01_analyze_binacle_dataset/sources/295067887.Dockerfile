FROM ubuntu:16.04
Maintainer Ethan J. Jackson

RUN apt-get update && apt-get install -y \
        default-jre-headless \
	# wget is used to download Spark, and is used (once the container starts) to
	# get the container's public IP address by reading checkip.amazonaws.com.
        wget \
&& wget -qO- https://www-us.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz | tar -xzf - \
&& mv /spark* /spark \
# Add the AWS jars so Spark can connect to S3.
&& wget -q -O /spark/jars/aws-java-sdk.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
&& wget -q -O /spark/jars/hadoop-aws.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar \
&& rm -rf /var/lib/lists/* /tmp/* /var/tmp/*

# Create a directory for the Spark event log, which stores information about
# past jobs that have completed. Spark requires this directory to be created;
# Spark will not create the directory itself. This filepath is the default
# location that Spark uses.  If the user changes the default location by
# configuring spark.eventLog.dir, this path will need to be updated to match.
RUN mkdir -p /tmp/spark-events

ENV PATH /spark/sbin:/spark/bin:$PATH
