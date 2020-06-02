FROM cblomart/vsphere-graphite:v0.7c
COPY vsphere-graphite.json /etc/vsphere-graphite.json
ENTRYPOINT [ "/vsphere-graphite" ]
