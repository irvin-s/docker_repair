FROM bigm/base-jdk7

RUN /xt/tools/_install_admin_tools

#= gocd
ENV GOCD_VERSION 14.4.0-1356
RUN /xt/tools/_apt_install unzip adduser
RUN groupadd -r go \
    && useradd -r -c "Go User" -g go -d /var/go -m -s /bin/bash go \
    && mkdir -p /var/lib/go-server/addons /var/log/go-server /etc/go /go-addons \
    && chown -R go:go /var/lib/go-server /var/log/go-server /etc/go /go-addons
RUN /xt/tools/_download /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-$GOCD_VERSION.deb f4ebef6d75735b884fc6eeaa8e53a3314f032bdc \
    && dpkg -i --debug=10 /tmp/go-server.deb \
    && rm /tmp/go-server.deb \
    && sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server

##= .gocd
#
## configure
ADD supervisor/gocd-server.conf /etc/supervisord.d/
##ADD startup/gocd-server /prj/startup/
#
##CMD ["/prj/bin/run_gocd"]
VOLUME ["/var/lib/go-server", "/var/log/go-server", "/etc/go", "/go-addons"]
EXPOSE 8153 8154
