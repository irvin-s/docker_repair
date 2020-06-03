FROM prom/alertmanager:v0.4.2  
ENV "ALERTMANAGER_BIN=/bin/alertmanager" \  
"WEBHOOK_URL=http://alert:8080/"  
COPY rootfs /  
  
ENTRYPOINT [ "/start.sh" ]  
CMD [ "-config.file=/etc/alertmanager/config.yml", \  
"-storage.path=/alertmanager" ]  

