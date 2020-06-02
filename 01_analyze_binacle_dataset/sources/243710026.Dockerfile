FROM karlstoney/jvm:latest
RUN yum install -q -y git-core

ENV LEIN_ROOT true
ENV ZKWEB_HOME /opt/zk-web

RUN cd /usr/local/bin && \
	wget --quiet https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
	chmod +x lein

RUN cd /opt && \
    git clone https://github.com/qiuxiafei/zk-web.git && \
    cd zk-web && \
    lein deps

COPY run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
