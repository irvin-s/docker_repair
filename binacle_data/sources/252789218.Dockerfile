FROM dtgilles/sshgw  
MAINTAINER dtgilles@t-online.de  
  
COPY entry.add /entry.add.10-scriptlog.sh  
COPY script_login* /usr/local/bin/  

