FROM anapsix/alpine-java
ARG hadoop_version=2.7.3
RUN apk add --no-cache --update \
    coreutils wget curl bash ca-certificates gnupg openssl su-exec tar
ENV HADOOP_VERSION $hadoop_version
ENV HADOOP_HOME /opt/hadoop
RUN wget -O /tmp/KEYS https://dist.apache.org/repos/dist/release/hadoop/common/KEYS \
    && gpg --import /tmp/KEYS \
    && wget -q -O /tmp/hadoop.tar.gz http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz  \
    && wget -O /tmp/hadoop.asc https://dist.apache.org/repos/dist/release/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz.asc \
    && gpg --verify /tmp/hadoop.asc /tmp/hadoop.tar.gz \
    && tar -xzf /tmp/hadoop.tar.gz -C /opt \
    && ln -s /opt/hadoop-$HADOOP_VERSION $HADOOP_HOME
ENV PATH="$HADOOP_HOME/sbin:$HADOOP_HOME/bin:${PATH}"
RUN mv "${HADOOP_HOME}/etc/hadoop" /etc/hadoop && ln -s /etc/hadoop "${HADOOP_HOME}/etc/hadoop"
ENV HADOOP_CONF_DIR /etc/hadoop
RUN apk del gnupg openssl tar \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
RUN addgroup -S hadoop \
    && adduser -h /var/lib/hadoop -G hadoop -S -H -s /bin/bash -g hadoop hadoop \
    && echo "hadoop:*" | chpasswd -e
RUN chown -R hadoop:hadoop $HADOOP_HOME
RUN mkdir -p /var/lib/hadoop \
    && chown -R hadoop:hadoop /var/lib/hadoop
RUN mkdir -p /var/log/hadoop \
    && chown -R hadoop:hadoop /var/log/hadoop
RUN mkdir -p /data/dfs/nn /data/dfs/dn \
    && chown -R hadoop:hadoop /data/dfs/nn /data/dfs/dn \
    && chmod 700 /data/dfs/nn /data/dfs/dn
COPY docker-entrypoint.sh /usr/local/bin/
USER hadoop
WORKDIR /var/lib/hadoop


ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["echo", "Please override CMD"]