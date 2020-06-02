#
# Basic Dockerfile for running OAI HSS Role and Init MySQL
#
FROM moffzilla/oai-epc:v01
MAINTAINER Francisco Poo Hernandez "francisco.poo.hernandez@ericsson.com"

ADD start_hss.sh /openair-cn/SCRIPTS/start_hss.sh
WORKDIR /openair-cn/SCRIPTS
RUN chmod 777 /openair-cn/SCRIPTS/start_hss.sh
CMD ["/openair-cn/SCRIPTS/start_hss.sh"]
