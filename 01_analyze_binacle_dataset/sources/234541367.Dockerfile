FROM elasticsearch
# --batch for non-interactive mode (auto-confirm warnings)
RUN bin/elasticsearch-plugin install --batch x-pack
RUN echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo "http.cors.enabled: true" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo "http.cors.allow-origin: '*'" >> /usr/share/elasticsearch/config/elasticsearch.yml
