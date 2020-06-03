#
# Configuration container for Cuckoo malware sandbox
#

FROM ubuntu:16.04
MAINTAINER Jacob Gajek <jacob.gajek@esentire.com>

COPY cuckoo/*.conf  	/opt/sandbox/cuckoo-modified/conf/
COPY tor/*		/etc/tor/
COPY routetor/*		/opt/sandbox/routetor/conf/

VOLUME ["/opt/sandbox/cuckoo-modified/conf", "/opt/sandbox/routetor/conf", "/etc/tor"]

CMD ["/bin/true"]
