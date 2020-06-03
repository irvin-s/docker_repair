FROM owncloud:8.2.2-apache  
  
# Install PHP LDAP extension  
RUN apt-get update && apt-get install -y libldap2-dev  
RUN docker-php-ext-configure ldap \--with-libdir=lib/x86_64-linux-gnu  
RUN docker-php-ext-install ldap  

