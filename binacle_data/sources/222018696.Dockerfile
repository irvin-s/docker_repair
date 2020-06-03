FROM search/solrcloud-zookeeper-docker
ARG nodeid=4
RUN\
	touch /zk-data/myid &&\
	echo ${nodeid} > /zk-data/myid &&\
	echo "server.4=zoo4:2888:3888" >> /zk/conf/zoo.cfg &&\
	echo "server.5=zoo5:2888:3888" >> /zk/conf/zoo.cfg &&\
	touch start.sh &&\
	echo "#!/usr/bin/env bash" >> start.sh &&\
	echo "./zk/bin/zkServer.sh start" >> start.sh &&\
	echo "./solr/bin/solr stop" >> start.sh &&\
	echo "./solr/bin/solr -cloud -z zoo4:2181,zoo5:2181 -s /solr-data" >> start.sh &&\
	echo "tail -F /solr/server/logs/solr.log" >> start.sh &&\
	chmod 755 start.sh
CMD	/bin/bash
