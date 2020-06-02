FROM fluent/fluentd:v0.12
COPY conf/fluent.conf /fluentd/etc/
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "1.9.5"]