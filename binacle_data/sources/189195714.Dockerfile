FROM bigm/base-jdk7

#= gocd
ENV GOCD_VERSION 14.4.0-1356
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-$GOCD_VERSION.deb 81fecad4101f61ca4cf32b6a3c73cbb5faedf9d3 \
    && dpkg -i /tmp/go-server.deb \
    && rm /tmp/go-agent.deb \
    && sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent /etc/default/go-agent
#= .gocd

# configure
#CMD ["/prj/bin/run_gocd"]
EXPOSE 8153 8154
