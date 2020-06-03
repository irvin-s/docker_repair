FROM search/node-fusion:latest
RUN\
	mv /fusion/conf/config.sh /fusion/conf/config.bak &&\
	mv /fconfig.sh /fusion/conf/config.sh
CMD	/bin/bash
