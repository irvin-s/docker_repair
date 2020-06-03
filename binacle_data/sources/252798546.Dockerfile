from deployable/ndjbdns:latest  
  
copy data /ndjbdns/etc/ndjbdns/  
copy ip /ndjbdns/etc/ndjbdns/  
copy tinydns.conf /ndjbdns/etc/ndjbdns/  
  
run set -uex; \  
cd /ndjbdns/etc/ndjbdns; \  
/ndjbdns/bin/tinydns-data  
  
copy entrypoint.sh /ndjbdns/bin/entrypoint.sh  
entrypoint ["/ndjbdns/bin/entrypoint.sh"]  
cmd ["tinydns"]  
  

