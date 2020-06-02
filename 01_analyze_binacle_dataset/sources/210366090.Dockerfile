FROM quay.io/pires/docker-elasticsearch-kubernetes:2.3.4

ADD elasticsearch.yml /elasticsearch/config/
ADD java.policy /usr/lib/jvm/default-jvm/jre/lib/security/
