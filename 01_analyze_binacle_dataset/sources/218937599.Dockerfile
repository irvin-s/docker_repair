FROM icclabcna/zurmo_log_courier
  
ADD log-courier.conf.tmpl /etc/confd/templates/log-courier.conf.tmpl
ADD log-courier.conf /etc/log-courier.conf
