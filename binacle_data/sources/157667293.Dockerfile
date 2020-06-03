FROM java7jre_image

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN (   SPARK_VERSION=1.3.0 && \
        apt-get update && \
        apt-get install -y wget && \
        wget -O /tmp/spark.tgz http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-cdh4.tgz && \
        cd /opt && tar xvf /tmp/spark.tgz && \
        rm -fv /tmp/spark.tgz && \
        ln -sn spark-${SPARK_VERSION}-bin-cdh4 /opt/spark && \
        apt-get install -y python python-pip curl jq libgfortran3 && \
        pip install python-consul && \
        apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*)

ADD app /app
ADD spark-jobs /spark-jobs
ADD startup-scripts /startup-scripts

# Define default command.
CMD ["/apps/bin/keep_alive"]

