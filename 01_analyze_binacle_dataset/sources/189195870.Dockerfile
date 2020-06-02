#BUILD_PUSH=hub,quay
FROM bigm/base-deb

# install confd
ENV CONFD_VER 0.11.0
RUN /xt/tools/_download /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-linux-amd64 \
	&& chmod  +x /usr/local/bin/confd

# install rsync
RUN /xt/tools/_apt_install rsync

ADD supervisor/* /etc/supervisord.d/
ADD startup/* /prj/startup/
ADD rsyncd.conf /etc/rsyncd.conf

ENV RSYNC_DAEMON 0
ENV ETCD_NODE ""
EXPOSE 873
VOLUME /prj/rsync
