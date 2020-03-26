FROM ubuntu:14.04

# install required packages
RUN apt-get update && apt-get install -y \
  openjdk-7-jre \
  make \
  git \
  wget \
  rubygems-integration \
  supervisor && \
  mkdir -p /var/log/supervisor

ADD logstash-1.4.2.tar.gz /logstash-1.4.2.tar.gz

# install log-courier logstash plugin
ADD install_courier_plugin.sh /install_courier_plugin.sh
RUN /install_courier_plugin.sh 

ADD logstash_courier.cfg /logstash/logstash_courier.cfg

# install confd
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 && \
	mv confd-0.7.1-linux-amd64 /usr/local/bin/confd && \
	chmod u+x /usr/local/bin/confd && \
	mkdir -p /etc/confd/{conf.d,templates}

# install etcd output plugin
RUN git clone https://github.com/icc-bloe/logstash-output-etcd.git && \
        cd logstash-output-etcd && \
        gem build logstash-output-etcd.gemspec && \
        cd /logstash-1.4.2.tar.gz/logstash-1.4.2 && \
        export GEM_HOME=vendor/bundle/jruby/1.9 && \
        java -jar vendor/jar/jruby-complete-1.7.11.jar -S gem install /logstash-output-etcd/logstash-output-etcd-0.1.0.gem

ADD elasticsearch.yml.tmpl /etc/confd/templates/elasticsearch.yml.tmpl
ADD elasticsearch.toml /etc/confd/conf.d/elasticsearch.toml
ADD confd.sh /confd.sh

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD kill_supervisor.py /usr/bin/kill_supervisor.py
ADD logstash_supervisord.conf /etc/supervisor/conf.d/logstash_supervisord.conf
ADD patterns /logstash/patterns

CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
