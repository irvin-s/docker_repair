FROM openjdk:8-jre-slim
LABEL "maintainer"="tangfeixiong <tangfx128@gmail.com>" \
    "project"="https://github.com/tangfeixiong/go-to-kubernetes" \
    "name"="hadoop-operator" \
    "version"="0.1-alpha" \
    "created-by"='{"linux":"4.11.8-300.fc26.x86_64","docker":"1.13.1","hadoop":"3.0.0"}'
ARG hadoop_dist_mirror=https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz
#ARG hadoop_dist_mirror=http://127.0.0.1:48080/Users/fanhongling/Downloads/99-mirror/https0x3A0x2F0x2Farchive.apache.org0x2Fdist/hadoop/hadoop-3.0.0.tar.gz
#ARG apache_dist_pkg=http://www.us.apache.org/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		gnupg \
		dirmngr \
	; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	\
	fetchDeps=' \
		ca-certificates \
        curl \
		wget \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*

RUN curl -jkSL $hadoop_dist_mirror | tar -C / -zx -f- \
    hadoop-3.0.0/sbin/ \
    hadoop-3.0.0/include/ \
    hadoop-3.0.0/LICENSE.txt \
    hadoop-3.0.0/libexec/ \
    hadoop-3.0.0/README.txt \
    hadoop-3.0.0/NOTICE.txt \
    hadoop-3.0.0/lib/ \
    hadoop-3.0.0/share/hadoop/ \
    hadoop-3.0.0/bin/ \
    hadoop-3.0.0/etc/

ENV DOCKER_API_VERSION='1.12' \
    DOCKER_CONFIG_JSON='{"auths": {"localhost:5000": {"auth": "","email": ""}}}' \
    REGISTRY_CERTS_JSON='{"localhost:5000": {"ca_base64": "", "crt_base64": "", "key_base64": ""}}' \
    HADOOP_VERSION=3.0.0 \
    HDFS_NAMENODE_OPTS="-XX:+UseParallelGC -Xmx4g"

EXPOSE 9000 50010 50020 50070 50075 50090 9871 9870 9820 9869 9868 9867 9866 9865 9864 19888 8030 8031 8032 8033 8040 8042 8088 8188 49707 2122

ENTRYPOINT ["/hadoop-3.0.0/bin/hdfs", "version"]
CMD ["--debug"]
