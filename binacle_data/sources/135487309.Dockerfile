FROM mdillon/postgis:9.5

RUN localedef --force --inputfile=fi_FI --charmap=UTF-8 --alias-file=/usr/share/locale/locale.alias fi_FI.UTF-8
ENV LANG fi_FI.utf8

COPY init.sql /docker-entrypoint-initdb.d/
