#FROM arm32v7/ubuntu
FROM ubuntu
WORKDIR /opt
RUN echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
RUN apt-get update;apt-get install curl software-properties-common -y;add-apt-repository ppa:linuxuprising/java
RUN apt-get update;apt-get install -y tar wget oracle-java12-installer
RUN wget -q -O eleastic-search.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.1.1-linux-x86_64.tar.gz
RUN tar xf eleastic-search.tar.gz -C /opt/
RUN useradd -s /bin/bash elasticsearch -d /home/elasticsearch -m
RUN chown -R elasticsearch:elasticsearch /opt/elasticsearch*
RUN sed -i 's/-Xms1g/-Xms300m/g' /opt/elasticsearch-7.1.1/config/jvm.options && sed -i 's/-Xmx1g/-Xmx300m/g' /opt/elasticsearch-7.1.1/config/jvm.options
RUN sed -i 's/#bootstrap.memory_lock: true/bootstrap.system_call_filter: false/i' /opt/elasticsearch*/config/elasticsearch.yml
RUN mkdir /opt/elasticsearch-7.1.1/tmp
RUN echo "-Djna.tmpdir=/opt/elasticsearch-7.1.1/tmp" >> /opt/elasticsearch-7.1.1/config/jvm.options
#RUN su - elasticsearch -c "echo y | /opt/elasticsearch*/bin/elasticsearch-plugin install ingest-geoip"
ADD start.sh /
CMD bash /start.sh
