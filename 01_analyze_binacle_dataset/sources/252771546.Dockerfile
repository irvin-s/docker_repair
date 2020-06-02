FROM centos:7  
MAINTAINER nnadmins <nna@nna.nb.no>  
  
RUN yum -y update \  
&& yum -y install epel-release \  
&& yum -y install nodejs npm git vim; yum clean all  
  
RUN git clone https://github.com/nlnwa/nnadmin.git nnadmin \  
&& npm install -g gulp \  
&& cd /nnadmin && npm install  
  
RUN groupadd -r nnadmin \  
&& useradd -r -g nnadmin nnadmin \  
&& chown -R nnadmin:nnadmin /nnadmin \  
&& mkdir /home/nnadmin/ \  
&& chown -R nnadmin:nnadmin /home/nnadmin/  
  
USER nnadmin  
  
ENV ldap_url='ldap://xxxxx:xxx' \  
ldap_bindDn='cn=Ldapreader,ou=xxx,DC=xxx' \  
ldap_bindCredentials='xxx' \  
ldap_searchBase='DC=xxx' \  
rethink_host='xxx.xxx.xxx.xxx' \  
rethink_db='xxx'  
WORKDIR /nnadmin/  
CMD gulp serve:dist  
  
EXPOSE 3000  

