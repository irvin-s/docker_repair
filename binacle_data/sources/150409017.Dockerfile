FROM relateiq/oracle-java7

# elasticsearch
RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

RUN wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.3.tar.gz
RUN tar -xf elasticsearch-0.90.3.tar.gz
RUN rm elasticsearch-0.90.3.tar.gz
RUN ln -sfn elasticsearch-0.90.3 elasticsearch
#RUN elasticsearch/bin/plugin -install elasticsearch/elasticsearch-mapper-attachments/1.8.0
#RUN elasticsearch/bin/plugin -i com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/1.7.0
RUN elasticsearch/bin/plugin -u https://github.com/downloads/jprante/elasticsearch-analysis-naturalsort/elasticsearch-analysis-naturalsort-1.0.0.zip -install elasticsearch-analysis-naturalsort
RUN elasticsearch/bin/plugin -install mobz/elasticsearch-head
RUN elasticsearch/bin/plugin -install lukas-vlcek/bigdesk
#RUN elasticsearch/bin/plugin -install elasticsearch/elasticsearch-cloud-aws/1.14.0

RUN mkdir /data
RUN mkdir /logs

VOLUME [ "/logs" ]
VOLUME [ "/data" ]

EXPOSE 9200
EXPOSE 9300

CMD ["elasticsearch/bin/elasticsearch", "-f", "-D", "es.path.logs=/logs", "-D", "es.path.data=/data", "-D", "es.network.publish_host=127.0.0.1", "-D", "es.cluster.name=search-localhost" ]
