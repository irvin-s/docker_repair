FROM ubuntu
MAINTAINER Tony Chong

RUN apt-get update && apt-get install unzip

ADD https://dl.bintray.com/mitchellh/consul/0.4.0_linux_amd64.zip /tmp/consul_0.4.0.zip
RUN unzip /tmp/consul_0.4.0.zip -d /usr/local/bin/

ADD https://dl.bintray.com/mitchellh/consul/0.4.0_web_ui.zip /tmp/consul_0.4.0_webui.zip
RUN mkdir -p /opt/consulweb && unzip /tmp/consul_0.4.0_webui.zip -d /opt/consulweb

CMD ["-server", "-bootstrap", "-data-dir", "/tmp/consul", "-ui-dir", "/opt/consulweb/dist", "-client=0.0.0.0"] 
ENTRYPOINT ["/usr/local/bin/consul", "agent"]
EXPOSE 8300 8302 8302/udp 8400 8500 8600 8600/udp
