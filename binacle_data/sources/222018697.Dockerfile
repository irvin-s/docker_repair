FROM search/solrcloud-zookeeper-docker
ARG nodeid=1
RUN\
	touch /zk-data/myid &&\
	echo ${nodeid} > /zk-data/myid  &&\
	echo "server.1=zoo1:2888:3888" >> /zk/conf/zoo.cfg &&\
	echo "server.2=zoo2:2888:3888" >> /zk/conf/zoo.cfg &&\
	echo "server.3=zoo3:2888:3888" >> /zk/conf/zoo.cfg &&\
	touch start.sh &&\
	echo "#!/usr/bin/env bash" >> start.sh &&\
	echo "./zk/bin/zkServer.sh start" >> start.sh &&\
	echo "./solr/bin/solr stop" >> start.sh &&\
	echo "./solr/bin/solr -cloud -z zoo1:2181,zoo2:2181,zoo3:2181 -s /solr-data" >> start.sh &&\
	echo "./solr/server/scripts/cloud-scripts/zkcli.sh -cmd upconfig -z localhost:2181 -confname data_driven -confdir ./solr/server/solr/configsets/data_driven_schema_configs/conf" >> start.sh &&\
	echo " ./etc/init.d/td-agent restart" >> starth.sh &&\
	echo "tail -F /solr/server/logs/solr.log" >> start.sh &&\
	chmod 755 start.sh
CMD	/bin/bash
