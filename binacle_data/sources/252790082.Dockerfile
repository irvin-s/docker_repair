FROM camptocamp/confd:v0.14.0  
ADD ./conf.d /etc/confd/conf.d  
ADD ./templates /etc/confd/templates  
  
ENTRYPOINT ["/confd/confd"]  
CMD ["--backend", "rancher", "--prefix", "/2016-07-29", "-interval", "60"]  

