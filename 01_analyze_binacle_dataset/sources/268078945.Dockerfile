#
# Basic Dockerfile for running OAI EPC Roles
#
FROM moffzilla/oai-epc:v01
MAINTAINER Francisco "francisco.poo.hernandez@ericsson.com"

ADD start_epc.sh /openair-cn/SCRIPTS/start_epc.sh
WORKDIR /openair-cn/SCRIPTS
RUN chmod 777 /openair-cn/SCRIPTS/start_epc.sh
CMD ["/openair-cn/SCRIPTS/start_epc.sh"]
