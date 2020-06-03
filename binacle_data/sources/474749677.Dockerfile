FROM neo4j
LABEL maintainer="Stéphane Fréchette"

ADD https://gist.githubusercontent.com/jexp/1e295d5f5b96e8e42fb614232abdbb4f/raw/ee277d2daec8aa54c031cbeede774abda9c9118b/neo4j-wait.sh ./
ADD https://gist.githubusercontent.com/syedhassaanahmed/1809fcce4cb15daaff79690932ea76bd/raw/6f660641eccf662936b13cf077465fbf9a46c1d2/neo4j-import.sh ./import.sh

COPY cypher/import.cypher ./
COPY data/ ./import/data/
RUN chmod +x *.sh && apk add --update curl && rm -rf /var/cache/apk/*

CMD ["./import.sh"]