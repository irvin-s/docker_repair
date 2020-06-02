FROM ubuntu
MAINTAINER hardikgw@gmail.com
ENV\
	ES_VER=2.3.4 \
	KB_VER=4.5.3 \
	FD_VER=3.4.8
RUN\
	apt-get update &&\
	apt-get install -y vim curl wget nodejs default-jdk monit lsof ntp &&\
	apt-get update &&\
	wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ES_VER/elasticsearch-$ES_VER.tar.gz &&\
	tar xzvf elasticsearch-$ES_VER.tar.gz &&\
	rm elasticsearch-$ES_VER.tar.gz &&\
	ln -s elasticsearch-$ES_VER es &&\
	mkdir es-data &&\
	wget https://download.elastic.co/kibana/kibana/kibana-$KB_VER-linux-x64.tar.gz &&\
	tar xzvf kibana-$KB_VER-linux-x64.tar.gz &&\
	rm kibana-$KB_VER-linux-x64.tar.gz &&\
	ln -s kibana-$KB_VER-linux-x64 kb &&\
	curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - &&\
	echo "deb http://packages.treasuredata.com/2/ubuntu/xenial/ xenial contrib" > /etc/apt/sources.list.d/treasure-data.list &&\
	apt-get update &&\
	apt-get install -y --force-yes td-agent &&\
	td-agent-gem install fluent-plugin-elasticsearch &&\
	apt-get clean &&\
	touch start.sh &&\
	chmod 755 start.sh &&\
	echo "#!/bin/sh" >> start.sh &&\
	echo "service td-agent start" >> start.sh &&\
	echo "./es/bin/elasticsearch -Des.insecure.allow.root=true -d" >> start.sh &&\
	echo "nohup ./kb/bin/kibana &" >> start.sh &&\
	echo "monit -I" >> start.sh
COPY td-agent.conf /etc/td-agent/td-agent.conf
EXPOSE 5601 9200 9300 24224