FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get -y install ubuntu-cloud-keyring software-properties-common  
RUN set -x \  
&& add-apt-repository cloud-archive:ocata \  
&& apt-get -y update \  
&& apt-get -y install python-mysqldb \  
&& apt-get -y install keystone \  
&& apt-get -y install glance \  
&& apt-get -y install nova-api \  
&& apt-get -y install cinder-api \  
&& apt-get -y install neutron-server \  
&& apt-get -y install mysql-client \  
&& apt-get -y clean  
  
COPY dbtests.sh /dbtests.sh  
RUN chown root.root /dbtests.sh && chmod a+x /dbtests.sh  
  
COPY setup_db.sh /setup_db.sh  
RUN chown root.root /setup_db.sh && chmod a+x /setup_db.sh  
  
  
ENTRYPOINT ["top", "-b"]  
CMD ["-c"]  

