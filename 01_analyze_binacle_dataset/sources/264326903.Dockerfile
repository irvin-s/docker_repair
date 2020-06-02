FROM ubuntu
RUN apt-get update;apt-get install apt-utils apt-transport-https wget gnupg1 -y
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
RUN apt-get update && apt-get install kibana -y
RUN sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/i' /etc/kibana/kibana.yml
#RUN sed -i 's/#elasticsearch.url: "http:\/\/localhost:9200"/elasticsearch.url: "http:\/\/elasticsearch-master:9200"/i' /etc/kibana*/kibana.yml
RUN echo elasticsearch.hosts: ["http://elasticsearch-master:9200"] >> /etc/kibana*/kibana.yml
RUN sed -i 's/#server.port: 5601/server.port: 5601/i' /etc/kibana/kibana.yml
RUN sed -i 's/#elasticsearch.requestTimeout: 30000/elasticsearch.requestTimeout: 120000/i' /etc/kibana/kibana.yml
CMD /etc/init.d/kibana start;sleep infinity
