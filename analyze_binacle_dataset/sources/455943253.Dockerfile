FROM centos:latest

USER root
EXPOSE 3000

ENV GRAFANA_VERSION="5.3.2"

ADD root /
RUN yum -y install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-"$GRAFANA_VERSION"-1.x86_64.rpm \
    && yum clean all
COPY run.sh /usr/share/grafana/
RUN /usr/bin/fix-permissions /usr/share/grafana \
    && /usr/bin/fix-permissions /etc/grafana \
    && /usr/bin/fix-permissions /var/lib/grafana \
    && /usr/bin/fix-permissions /var/log/grafana 

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]
WORKDIR /usr/share/grafana
ENTRYPOINT ["./run.sh"]
