FROM animemint/sensu:1.4.2-3  
  
CMD dockerize -template /templates/config.json.tmpl:/etc/sensu/config.json \  
/opt/sensu/bin/sensu-server -c /etc/sensu/config.json -d /etc/sensu/conf.d  

