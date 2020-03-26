
FROM mozillamarketplace/centos-python27-mkt:latest

RUN yum install -y java-1.7.0-openjdk tar which

RUN mkdir -p /srv/elasticsearch
WORKDIR /srv/elasticsearch
RUN curl -O  https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.6.2.tar.gz
RUN tar -xvzf elasticsearch-1.6.2.tar.gz

WORKDIR /srv/elasticsearch/elasticsearch-1.6.2

RUN ./bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.6.0

RUN curl -o /srv/elasticsearch/marketplace.yml https://raw.githubusercontent.com/mozilla/zamboni/master/scripts/elasticsearch/elasticsearch.yml

RUN sed -i 's/localhost/0.0.0.0/' /srv/elasticsearch/marketplace.yml

CMD ./bin/elasticsearch -Des.config=/srv/elasticsearch/marketplace.yml
