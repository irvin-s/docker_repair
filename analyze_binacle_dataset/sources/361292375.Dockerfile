FROM scratch

MAINTAINER Guilherme Santos <guilherme.santos@neoway.com.br>

ADD ./es-reindex /opt/es-reindex/bin/

WORKDIR /opt/es-reindex/bin

ENTRYPOINT ["./es-reindex"] 
