FROM ceph/base

RUN apt-get update && \
    apt-get --no-install-recommends -y install collectd libpython2.7 python-pip git-core && \
    pip install envtpl

ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl

# collectd-ceph
RUN git clone https://github.com/rochaporto/collectd-ceph.git /tmp/collectd-ceph && \
    mkdir /usr/lib/collectd/plugins && \
    mv /tmp/collectd-ceph/plugins /usr/lib/collectd/plugins/ceph && \
    rm -rf /tmp/collectd-ceph

# ceph config dir should be available
VOLUME /etc/ceph

ADD ./run.sh /run.sh
ENTRYPOINT ["/run.sh"]
