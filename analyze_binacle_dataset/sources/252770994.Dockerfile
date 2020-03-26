FROM aguamala/centos:7  
MAINTAINER "gabo" <aguamala@deobieta.com>  
  
RUN yum install -y which duplicity s3cmd unzip && \  
yum clean all  
  
ADD https://github.com/zertrin/duplicity-backup.sh/archive/stable.zip /  
  
RUN unzip stable.zip && \  
cd duplicity-backup.sh-stable && \  
mv duplicity-backup.sh /usr/bin/duplicity-backup && \  
rm -rf duplicity-backup.sh-stable  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
COPY duplicity-backup.conf.sample /duplicity-backup.conf.sample  
CMD ["duplicity-backup"]  
ENTRYPOINT ["/entrypoint.sh"]  

