FROM      ubuntu
MAINTAINER Dustin Sallings "dustin@spy.net"

ADD http://cbfs-ext.hq.couchbase.com/projects/couchbasecloud/confproxy/confproxy.lin64 /usr/local/sbin/confproxy

RUN chmod 755 /usr/local/sbin/confproxy
