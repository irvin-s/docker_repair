FROM michaelhuettermann/infra
MAINTAINER Michael Huettermann
 
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

RUN echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | tee /etc/apt/sources.list.d/elasticsearch.list
RUN echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | tee /etc/apt/sources.list.d/logstash.list

RUN sudo apt-get update
RUN sudo apt-get -y install elasticsearch=1.4.4

ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

RUN wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz  
RUN tar xvf kibana*.tar.gz

RUN apt-get install logstash

ADD 01-apache-input.conf /etc/logstash/conf.d/01-apache-input.conf
RUN chmod +x /etc/logstash/conf.d/01-apache-input.conf
   
RUN ln -s /lib/x86_64-linux-gnu/libcrypt.so.1 /usr/lib/x86_64-linux-gnu/libcrypt.so   

#9200 elasticsearch
#5601 kibana
EXPOSE 9200 5601

CMD ["/root/run.sh"]



