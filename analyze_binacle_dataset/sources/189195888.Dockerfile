#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools

RUN /xt/tools/_ppa_install ppa:builds/sphinxsearch-rel22 sphinxsearch
RUN export SPH_API_KEY=REPLKEY \
  && bash -c "$(curl -s https://tools.sphinxsearch.com/downloads/latest/install-monitor)"
ADD sphinxagent.json /usr/local/sphinxmonitor/conf/sphinxagent.json

RUN rm -fr /tmp/*

### etc configuration
ADD etc/sphinxsearch /etc/sphinxsearch
RUN rm -f /etc/sphinxsearch/sphinx.conf

# main sphinx server location
ENV SPHINXSEARCH_CONFIG_MAIN "/etc/sphinxsearch/main.conf"
# space separated folders with additionals configuration files
ENV SPHINXSEARCH_CONFIG_D "/etc/sphinxsearch/conf.d"
# Sphinx Agens activation
ENV SPH_API_KEY ""
# run indexer on start
ENV SPHINXSEARCH_STARTUP_INDEXER "--rotate --all"

# startup
COPY startup/* /prj/startup/
ADD supervisor/* /etc/supervisord.d/

# expose ports
EXPOSE 9306 9312
# here index data are stored
VOLUME ["/var/lib/sphinxsearch"]
