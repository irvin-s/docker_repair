FROM camptocamp/confd:v0.12.0-alpha3  
  
ADD ./conf.d /etc/confd/conf.d  
ADD ./templates /etc/confd/templates  
ADD ./.placeholder /etc/rsyslog-confd/.placeholder  
  
ENTRYPOINT ["/confd/confd"]  
CMD ["--backend", "env", "--onetime"]  

