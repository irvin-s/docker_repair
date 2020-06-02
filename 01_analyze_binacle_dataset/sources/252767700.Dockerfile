FROM mysql  
MAINTAINER Amer Child <achild@basis.com>  
  
# Add conf for bugzilla parameters  
ADD bugzilla.cnf /etc/mysql/conf.d/

