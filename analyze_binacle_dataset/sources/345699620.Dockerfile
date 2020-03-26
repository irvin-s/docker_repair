# docker-elasticsearch-cn
# docker pull hangxin1940/docker-elasticsearch-cn:v2.1.1
FROM java:openjdk-7-jre
MAINTAINER hangxin1940 <hangxin1940@gmail.com>

RUN wget -q http://github.com/hangxin1940/elasticsearch-cn-out-of-box/archive/v2.1.1.zip && unzip -qq v2.1.1.zip && \
    mv /elasticsearch-cn-out-of-box-2.1.1 /elasticsearch && \
    rm /elasticsearch/bin/*.exe && \
    rm -rf /elasticsearch/bin/service && \
    rm v2.1.1.zip

RUN mkdir /data /logs

VOLUME ["/data", "/logs"]

ENV ES_HOME /elasticsearch

ADD docker-start /elasticsearch/bin/docker-start

EXPOSE 9200 9300
CMD ["/elasticsearch/bin/docker-start"]
