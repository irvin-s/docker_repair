FROM zabbix/zabbix-3.0  
MAINTAINER Gennadiy Dubina <gdubina@dataart.com>  
  
RUN yum install -y python-pip && \  
pip install --upgrade pip && \  
pip install pyzabbix && \  
yum autoremove -y python-pip  
  
ADD conf/jujuapi.yaml /usr/lib/zabbix/externalscripts/jujuapi.yaml  
ADD conf/jujuapicli /usr/lib/zabbix/externalscripts/jujuapicli  
ADD conf/zabbixapi.yaml /usr/lib/zabbix/externalscripts/zabbixapi.yaml  
ADD conf/delete_host.py /usr/lib/zabbix/externalscripts/delete_host.py  
  
ADD files/zabbix_content /opt/zabbix_content  
ADD files/import_content.sh /opt/zabbix_content/restcomm_import.sh  
ADD files/import_contentd.sh /config/init/restcomm_importd.sh  

