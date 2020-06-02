#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools

# install confd
ENV CONFD_VER 0.11.0
RUN /xt/tools/_download /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
	&& chmod  +x /usr/local/bin/confd

# install haproxy
RUN /xt/tools/_ppa_install ppa:vbernat/haproxy-1.6 haproxy

# add haproxy templates
ADD root/ /
# folders under /xt/defaults will be populated in instance if they are empty
RUN mkdir -p /xt/defaults/etc \
    && cp -rp /etc/confd /xt/defaults/etc/confd

# final
ADD supervisor.d/* /etc/supervisord.d/
ADD startup/* /prj/startup/
EXPOSE 8080 1000
