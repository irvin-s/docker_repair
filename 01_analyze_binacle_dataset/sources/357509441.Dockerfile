FROM elasticsearch:1

RUN plugin -install mobz/elasticsearch-head

EXPOSE 9200
EXPOSE 9300
