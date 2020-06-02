FROM centos:6

MAINTAINER xzdbd <xzdbd@sina.com>

COPY ./* /tmp/

RUN yum install -y net-tools && \
    yum install -y fontconfig && \
    yum install -y freetype && \
    yum install -y gettext && \
    yum install -y libXfont && \
    yum install -y mesa-libGL && \
    yum install -y mesa-libGLU && \
    yum install -y Xvfb && \
    /usr/sbin/useradd --create-home --home-dir /usr/local/arcgis --shell /bin/bash arcgis

USER arcgis

ENV HOME /usr/local/arcgis

RUN tar xvzf /tmp/ArcGIS_for_Server_Linux_103_142158.tar.gz -C /tmp/ && \
	/tmp/ArcGISServer/Setup -m silent -l yes -a /tmp/arcgisserver.ecp

EXPOSE 1098 4000 4001 4002 4003 4004 6006 6080 6099 6443	

USER root

RUN rm /tmp/ArcGIS_for_Server_Linux_103_142158.tar.gz && \
	rm -rf /tmp/ArcGISServer

CMD /bin/bash	