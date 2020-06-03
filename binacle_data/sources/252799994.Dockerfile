FROM kamon/grafana_graphite  
  
RUN apt-get -y update \  
&& apt-get -y install nfs-common \  
&& mkdir /efs  
  
# Dirs inside efs do not exist yet, we just need to point symlinks to them  
RUN rm -rf /opt/graphite/storage/whisper  
RUN ln -sf /efs/opt-graphite-storage-whisper /opt/graphite/storage/whisper  
  
RUN rm -rf /var/lib/elasticsearch  
RUN ln -sf /efs/var-lib-elasticsearch /var/lib/elasticsearch  
  
RUN rm -rf /opt/grafana/data  
RUN ln -sf /efs/opt-grafana-data /opt/grafana/data  
  
RUN rm -rf /opt/graphite/storage/log  
RUN ln -sf /efs/opt-graphite-storage-log /opt/graphite/storage/log  
  
RUN rm -rf /var/log  
RUN ln -sf /efs/var-log /var/log  
  
ADD entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

