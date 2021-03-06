# Load minimum of 32-bit runtime rpms as per MOS Note  2197176.1
# copy instantclient rpms 
# copy tnsnames.ora if required and set TNS_ADMIN

FROM oraclelinux:latest

COPY oracle-instantclient12.2-*.rpm /
COPY  tnsnames.ora /config/

RUN yum -y install \
 ksh \
 tcsh \
 libstdc++.i686 \
 glibc.i686 \
 libaio.i686 \
&& yum -y localinstall   oracle-instantclient12.2-*.i386.rpm \
&& yum clean all \
&& rm -rf /var/cache/yum/x86_64  \
&& rm -rf /var/cache/yum/i686 \
&& rm oracle-instantclient12.2*.rpm \
&& ln -s /usr/lib/oracle/12.2/client/lib/libclntsh.so.12.1 /usr/lib/oracle/12.2/client/lib/libclntsh.so \
&& chmod 777 /config/tnsnames.ora

ENV ORACLE_HOME=/usr/lib/oracle/12.2/client \
    TNS_ADMIN=/config/ \
    LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client/lib:${LD_LIBRARY_PATH}"  \
    PATH="/usr/lib/oracle/12.2/client/bin:${PATH}" \ 
    LANG=en_US.UTF-8 
