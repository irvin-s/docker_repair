FROM java:8-jdk

EXPOSE 9200 9300

RUN groupadd -r elastic && useradd -r -g elastic elastic

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.tar.gz &&\
 tar xvf elasticsearch-5.2.0.tar.gz &&\
 rm elasticsearch-5.2.0.tar.gz &&\
 mkdir -p /opt/ &&\
 mv /elasticsearch-5.2.0 /opt/elasticsearch &&\
 chown -R elastic:elastic /opt/elasticsearch &&\
 apt-get update &&\
 apt-get -y install gettext-base

RUN mkdir /es-data
VOLUME /es-data

COPY elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
COPY jvm.options /opt/elasticsearch/config/jvm.options

COPY run.sh /home/elastic/run.sh
RUN chmod +x /home/elastic/run.sh

ENTRYPOINT ["/home/elastic/run.sh"]
