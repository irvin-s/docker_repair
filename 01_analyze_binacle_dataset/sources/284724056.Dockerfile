FROM fluent/fluentd:v0.12
COPY conf/fluent.conf /fluentd/etc/
RUN apk --update add ruby-bigdecimal
#RUN apk add --update mysql-dev
#RUN apk add libmysql-ruby libmysqlclient-dev
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "1.9.5"]
RUN ["gem", "install", "fluent-plugin-sql", "--no-document"]
RUN ["gem", "install", "mysql2","--version","0.3.20"]
