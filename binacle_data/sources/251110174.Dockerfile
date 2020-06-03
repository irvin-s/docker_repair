# Dockerfile

FROM  openjdk:8

MAINTAINER  Eugene Tseytlin <tseytlin@pitt.edu>

ADD NobleMentions-1.1.jar /usr/local/lib/
RUN echo '#!/bin/bash' >> /usr/local/bin/noble && \
	echo 'java -jar /usr/local/lib/NobleMentions-1.1.jar -docker'  >> /usr/local/bin/noble  && \
	chmod 755 /usr/local/bin/noble && \
	mkdir -p /input /output /ontology
	
CMD	["/usr/local/bin/noble"]
