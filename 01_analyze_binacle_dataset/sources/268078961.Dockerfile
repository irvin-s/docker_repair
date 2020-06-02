#
# Basic Dockerfile for running OAI HSS Role and Init MySQL
#
FROM moffzilla/oai-epc:v01
MAINTAINER Francisco Poo Hernandez "francisco.poo.hernandez@ericsson.com"

ADD start_mme.sh /openair-cn/SCRIPTS/start_mme.sh
ADD mme_fd.conf /usr/local/etc/oai/freeDiameter/mme_fd.conf
ADD mme.conf /usr/local/etc/oai/mme.conf
RUN chmod 777 /usr/local/etc/oai/freeDiameter/mme_fd.conf
RUN chmod 777 /usr/local/etc/oai/mme.conf
WORKDIR /openair-cn/SCRIPTS
RUN chmod 777 /openair-cn/SCRIPTS/start_mme.sh
CMD ["/openair-cn/SCRIPTS/start_mme.sh"]
