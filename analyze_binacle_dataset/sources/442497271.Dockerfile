FROM ubuntu

MAINTAINER mpr@touk.pl

ENV ORACLE_SID XE

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe

ADD ./files /tmp/filesOracle

RUN ./tmp/filesOracle/install.sh

CMD /run.sh

EXPOSE 1521

