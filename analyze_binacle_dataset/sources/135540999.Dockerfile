from registry

env CACHE_REDIS_HOST 127.0.0.1
env CACHE_REDIS_PORT 6379
env CACHE_LRU_REDIS_HOST 127.0.0.1
env CACHE_LRU_REDIS_PORT 6379

expose 80

run apt-get update
run apt-get -y upgrade
run apt-get install -y apache2-utils supervisor python-setuptools nginx redis-server libssl-dev wget curl

run rm /etc/rc*.d/*nginx

RUN wget --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.3.0/confd_0.3.0_linux_amd64.tar.gz -O confd_0.3.0_linux_amd64.tar.gz 2>/dev/null
RUN tar -zxf confd_0.3.0_linux_amd64.tar.gz
RUN mv confd /usr/local/bin/confd

ADD registry.users.tmpl /etc/confd/templates/
ADD registry.users.toml /etc/confd/conf.d/
add run.sh /usr/local/bin/run
cmd ["/usr/local/bin/run"]
