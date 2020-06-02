FROM htdvisser/taiga-back  
  
RUN pip install taiga-contrib-ldap-auth ldap3  
  
ADD configure_ldap /tmp/configure_ldap  
ADD add_ldap_configuration.sh /tmp/add_ldap_configuration.sh  
  
ADD configure_initial_db_values /tmp/configure_initial_db_values  
ADD add_initial_configuration.sh /tmp/add_initial_configuration.sh  
  
RUN /tmp/add_ldap_configuration.sh  
RUN /tmp/add_initial_configuration.sh  

