from deployable/ndjbdns:latest  
  
copy dnscache.conf /ndjbdns/etc/ndjbdns/  
copy ip /ndjbdns/etc/ndjbdns/ip  
copy servers /ndjbdns/etc/ndjbdns/servers  
  
copy entrypoint.sh /ndjbdns/bin/entrypoint.sh  
entrypoint ["/ndjbdns/bin/entrypoint.sh"]  
cmd []  
  

