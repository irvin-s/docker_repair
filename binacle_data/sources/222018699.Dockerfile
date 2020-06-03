FROM search/node-fusion:latest
COPY conf/fconfig.sh /fusion/conf/config.sh
COPY conf/start-fusion.sh /start.sh
RUN\
	chmod 755 start.sh