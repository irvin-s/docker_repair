FROM kibana
RUN kibana-plugin install x-pack
RUN echo "xpack.security.enabled: false" > /usr/share/kibana/kibana.yml
