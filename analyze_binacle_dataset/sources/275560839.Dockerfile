FROM centos:7

COPY bundle/ /

RUN yum install -y epel-release
RUN yum install -y varnish varnish-agent hitch

COPY conf/ /

RUN /root/hitch_gen_conf.sh /etc/hitch/hitch.conf /etc/hitch/pems

EXPOSE 80
EXPOSE 443
EXPOSE 6085

CMD /root/varnish-suite.sh
