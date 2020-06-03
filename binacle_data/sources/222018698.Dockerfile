FROM search/fluentd-elastic-kibana-docker
MAINTAINER hardikgw@gmail.com
RUN\
	apt-get install monit &&\
	echo "tail -F /var/log/td-agent/td-agent.log" >> start.sh
EXPOSE 5601 9200 9300 24224