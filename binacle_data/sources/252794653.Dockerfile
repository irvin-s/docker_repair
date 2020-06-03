FROM datasyscz/oracledb-base  
  
# Nainstalovat potřebné balíčky  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
bc \  
libaio1 \  
rlwrap \  
&& rm -rf /var/lib/apt/lists/*  
  
# Zajistit předpoklady pro instalaci balíčku  
COPY chkconfig /sbin  
RUN chmod 755 /sbin/chkconfig \  
&& ln -s /usr/bin/awk /bin/awk \  
&& mkdir /var/lock/subsys  
  
# Nainstalovat Oracle  
RUN dpkg --install oracle-xe_11.2.0-2_amd64.deb \  
&& rm oracle-xe_11.2.0-2_amd64.deb  
  
# Nastavit proměnné prostředí  
ENV ORACLE_SID=XE \  
ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe \  
ORACLE_DATA=/u01/app/oracle/oradata/XE \  
TZ=Europe/Prague  
ENV PATH=$PATH:$ORACLE_HOME/bin  
  
# Připravit startovací skript  
WORKDIR /  
COPY docker-entrypoint.sh /  
RUN chmod 755 /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
# Vystavit porty a svazky  
EXPOSE 1521 8080  
#VOLUME /usr/lib/oracle/xe/oradata/XE  

