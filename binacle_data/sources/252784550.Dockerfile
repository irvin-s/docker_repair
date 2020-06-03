FROM ubuntu:16.04  
  
RUN apt-get update &&\  
apt-get install -y python-pip libffi-dev libssl-dev &&\  
apt-get install -y subversion python-svn &&\  
apt-get install -y apache2 libapache2-mod-wsgi &&\  
apt-get install -y python-mysqldb mysql-client &&\  
apt-get install -y libldap2-dev libsasl2-dev &&\  
pip install -U pip setuptools &&\  
pip install ReviewBoard &&\  
pip install python-ldap &&\  
a2dismod mpm_event && a2enmod mpm_prefork  
  
VOLUME /var/www  
  
ADD run.sh /  
  
ENTRYPOINT ["/run.sh"]  
  

