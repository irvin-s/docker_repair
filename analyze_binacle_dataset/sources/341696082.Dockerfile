FROM mysql:8.0.15

LABEL maintainer="Bert Oost <hello@bertoost.com>"

RUN apt-get update \
    && apt-get install -y rename \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove

COPY conf.d/* /etc/mysql/temp/
COPY custom/* /etc/mysql/temp/

# Rename temp files to .cnf + copy to conf.d/ directory (since that one is loaded)
RUN cd /etc/mysql/temp \
    && rename "s/\.conf/\.cnf/" *.conf \
    && cp /etc/mysql/temp/*.cnf /etc/mysql/conf.d/