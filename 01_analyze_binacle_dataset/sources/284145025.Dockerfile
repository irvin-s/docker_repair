FROM docker.elastic.co/elasticsearch/elasticsearch:6.1.3

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install analysis-smartcn
RUN elasticsearch-plugin install analysis-stempel