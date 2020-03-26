FROM java7

MAINTAINER Atos
EXPOSE 4502
ENTRYPOINT ["/conf_2_run.sh"]
ENV CQ_RUNMODE author
ENV CQ_PORT 4502
VOLUME ["/pkgs"]

RUN yum update -y && yum install -y unix2dos && \
	yum clean all && \
	mkdir -p /pkgs /opt/aem /hotfixes

ADD files/cq-author /etc/default/
RUN mkdir -m 770 /var/run/aem

ADD files/license.properties /opt/aem/author/
ADD files/AEM_6.0_Quickstart.jar /opt/aem/author/cq-author-p4502.jar
RUN cd /opt/aem/author/ && \
	java -jar cq-author-p4502.jar -unpack -v && \
	mkdir /opt/aem/author/crx-quickstart/install
ADD files/AEM_6.0_Service_Pack_1-1.0.zip /opt/aem/author/crx-quickstart/install/

ADD files/jaas.conf /opt/aem/author/crx-quickstart/conf/

ADD hotfixes/* /hotfixes/
ADD aem_first_run.sh examine_log.sh /
RUN /aem_first_run.sh && \
	rm -rv /hotfixes && \
	mkdir -p /segmentstore && \
	mv /opt/aem/author/crx-quickstart/repository/segmentstore/* /segmentstore

ADD conf_2_run.sh web_conf.sh /
