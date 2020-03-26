FROM alpine:latest  
  
MAINTAINER Ian D. Rossi <ian.d.rossi@aimtheory.com>  
  
RUN \  
mkdir -p /aws && \  
apk -Uuv add groff less python py-pip git && \  
pip install awscli requests && \  
apk --purge -v del py-pip && \  
rm /var/cache/apk/*  
  
WORKDIR /backup-tool  
  
RUN git clone https://github.com/ysde/grafana-backup-tool.git /backup-tool  
  
COPY grafana_s3_backup.sh /backup-tool/grafana_s3_backup.sh  
  
ENTRYPOINT sh grafana_s3_backup.sh  

