FROM java7

MAINTAINER Atos
EXPOSE 4503
ENTRYPOINT ["/conf_2_run.sh"]
ENV CQ_RUNMODE publish
ENV CQ_PORT 4503
RUN mkdir -p /pkgs /opt/aem /hotfixes /segmentstore

ADD files/cq-publish /etc/default/
RUN mkdir -m 770 /var/run/aem && \
	mkdir -p /opt/aem/publish

ADD files/license.properties /opt/aem/publish/
ADD files/AEM_6.0_Quickstart.jar /opt/aem/publish/cq-publish-p4503.jar

RUN cd /opt/aem/publish && \
	java -jar cq-publish-p4503.jar -unpack && \
	mkdir /opt/aem/publish/crx-quickstart/install
COPY files/AEM_6.0_Service_Pack_1-1.0.zip /opt/aem/publish/crx-quickstart/install/

ADD hotfixes/* /hotfixes/
ADD aem_first_run.sh examine_log.sh /
RUN /aem_first_run.sh && \
	rm -rv /hotfixes && \
	mv -v /opt/aem/publish/crx-quickstart/repository/segmentstore/* /segmentstore/

ADD conf_2_run.sh web_conf.sh /
