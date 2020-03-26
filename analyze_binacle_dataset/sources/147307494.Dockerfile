FROM java:openjdk-7u79-jre
MAINTAINER SequenceIQ

# Elastic search 1.1.1
# Kibana 3.0.1

#Install Elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' | tee /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update
RUN apt-get -y install elasticsearch=1.1.1
#RUN echo "script.disable_dynamic: true" >> /etc/elasticsearch/elasticsearch.yml
ADD es/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN mkdir -p /es-data

#Workaround regarding ulimit privileges
RUN sed -i.bak '/MAX_OPEN_FILES" ]; then/,+4 s/^/#/' /etc/init.d/elasticsearch
RUN sed -i.bak '/MAX_LOCKED_MEMORY" ]; then/,+4 s/^/#/' /etc/init.d/elasticsearch
RUN sed -i.bak '/MAX_MAP_COUNT" ]; then/,+4 s/^/#/' /etc/init.d/elasticsearch

#ElasticHQ plugin ( http://192.168.59.103:9200/_plugin/HQ )
RUN cd /usr/share/elasticsearch/bin && ./plugin -install royrusso/elasticsearch-HQ

#Install Kibana
RUN cd /root && wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz && tar xvf kibana-3.1.0.tar.gz
RUN mkdir -p /usr/share/kibana3 && cp -R /root/kibana-3.1.0/* /usr/share/kibana3/


#Install Nginx for kibana
RUN apt-get install -y nginx apache2-utils
ADD server/nginx.conf /etc/nginx/sites-available/default

#Bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

VOLUME /var/log

ENTRYPOINT ["/etc/bootstrap.sh"]

CMD ["-d"]
