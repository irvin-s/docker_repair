FROM centos:7.0.1406

LABEL maintainer="xzdbd@sina.com"

RUN yum install -y net-tools fontconfig freetype gettext libXfont mesa-libGL mesa-libGLU Xvfb libXtst libXi libXrender vim tar hostname

COPY ./* /tmp/

RUN groupadd arcgis && \
    useradd -m -r arcgis -g arcgis && \
    mkdir -p /arcgis/server && \
    chown -R arcgis:arcgis /arcgis && \
    chown -R arcgis:arcgis /tmp && \
    chmod -R 755 /arcgis

RUN echo -e "arcgis soft nofile 65535\narcgis hard nofile 65535\narcgis soft nproc 25059\narcgis hard nproc 25059" >> /etc/security/limits.conf

EXPOSE 1098 4000 4001 4002 4003 4004 6006 6080 6099 6443

USER arcgis

RUN tar xvzf /tmp/ArcGIS_for_Server_Linux_1041_151978.tar.gz -C /tmp/