FROM phusion/baseimage:0.9.15
MAINTAINER Jose Luis Ruiz <jose@wazuh.com>

# Update repositories, install git, gcc, wget, make and java8 and
# clone down the latest OSSEC build from the official Github repo.
RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN apt-get update && apt-get install -y python-software-properties debconf-utils daemontools wget
RUN add-apt-repository -y ppa:webupd8team/java &&\
    apt-get update &&\
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections &&\
    apt-get -yf install oracle-java8-installer


RUN wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - &&\
     echo "deb https://packages.elasticsearch.org/logstash/2.1/debian stable main" | sudo tee -a /etc/apt/sources.list &&\
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - &&\
    echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list &&\
    echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

RUN apt-get update && apt-get install -y vim expect gcc make libssl-dev unzip logstash elasticsearch

RUN cd root && mkdir ossec_tmp && cd ossec_tmp

# Copy the unattended installation config file from the build context
# and put it where the OSSEC install script can find it. Then copy the
# process. Then run the install script, which will turn on just about
# everything except e-mail notifications


RUN wget https://github.com/wazuh/ossec-wazuh/archive/v1.1.1.tar.gz &&\
    tar xvfz v1.1.1.tar.gz &&\
    mv wazuh-1.1.1 /root/ossec_tmp/ossec-wazuh &&\
    rm v1.1.1.tar.gz
#ADD ossec-wazuh /root/ossec_tmp/ossec-wazuh
COPY preloaded-vars.conf /root/ossec_tmp/ossec-wazuh/etc/preloaded-vars.conf

RUN /root/ossec_tmp/ossec-wazuh/install.sh

RUN wget https://github.com/wazuh/wazuh-api/archive/v1.2.tar.gz &&\
    tar xvfz v1.2.tar.gz &&\
    mkdir -p /var/ossec/api && cp -r wazuh-api-1.2/* /var/ossec/api &&\
    cd /var/ossec/api && npm install

RUN rm -rf wazuh-api-1.2 && rm v1.2.tar.gz
RUN apt-get remove --purge -y gcc make && apt-get clean

# Set persistent volumes for the /etc and /log folders so that the logs
# and agent keys survive a start/stop and expose ports for the
# server/client ommunication (1514) and the syslog transport (514)

ADD default_agent /var/ossec/default_agent
RUN service ossec restart &&\
  /var/ossec/bin/manage_agents -f /default_agent &&\
  rm /var/ossec/default_agent &&\
  service ossec stop &&\
  echo -n "" /var/ossec/logs/ossec.log


##LOGSTASH configuration

RUN cp /root/ossec_tmp/ossec-wazuh/extensions/logstash/01-ossec-singlehost.conf /etc/logstash/conf.d/ &&\
    cp /root/ossec_tmp/ossec-wazuh/extensions/elasticsearch/elastic-ossec-template.json  /etc/logstash/ &&\
    curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" &&\
    gzip -d GeoLiteCity.dat.gz && sudo mv GeoLiteCity.dat /etc/logstash/ &&\
    usermod -a -G ossec logstash

#Elasticsearch Configuration

ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

#KIBANA4.5 configuration

RUN apt-get -y install kibana python-requests

ADD wazuh_kibana_installer.py /tmp


ADD data_dirs.env /data_dirs.env
ADD init.bash /init.bash
# Sync calls are due to https://github.com/docker/docker/issues/9547
RUN chmod 755 /init.bash &&\
  sync && /init.bash &&\
  sync && rm /init.bash


ADD run.sh /tmp/run.sh
RUN chmod 755 /tmp/run.sh

VOLUME ["/var/ossec/data"]

EXPOSE 55000/tcp 1514/udp 1515/tcp 5601/tcp 514/udp

# Run supervisord so that the container will stay alive

ENTRYPOINT ["/tmp/run.sh"]
