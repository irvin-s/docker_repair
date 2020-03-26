FROM fluent/fluentd:v0.14
#RUN gem install fluent-plugin-mysql-replicator -v 0.6.1
#RUN ["gem", "install", "fluent-plugin-mysql-replicator","-v", "0.6.1"]
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "1.9.5"]

