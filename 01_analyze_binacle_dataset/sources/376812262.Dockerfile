FROM      dustin/tiny
MAINTAINER Dustin Sallings "dustin@spy.net"

ADD http://cbfs-ext.hq.couchbase.com/projects/sync_gateway/sync_gateway.lin64.gz /usr/local/sbin/sync_gateway.gz

RUN gzip -d /usr/local/sbin/sync_gateway.gz
RUN chmod 755 /usr/local/sbin/sync_gateway
