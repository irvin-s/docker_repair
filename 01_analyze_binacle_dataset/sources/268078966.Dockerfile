#
# Basic Dockerfile for running OAI HSS Role and Init MySQL
#
FROM moffzilla/oai-epc:v01
MAINTAINER Francisco Poo Hernandez "francisco.poo.hernandez@ericsson.com"

ADD start_spgw.sh /openair-cn/SCRIPTS/start_spgw.sh
WORKDIR /openair-cn/SCRIPTS
RUN chmod 777 /openair-cn/SCRIPTS/start_spgw.sh
CMD ["/openair-cn/SCRIPTS/start_spgw.sh"]
