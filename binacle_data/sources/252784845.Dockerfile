FROM alpine  
  
# purpose  
# pull in csvs from AWS S3  
# import those CSVs in to MySQL after dropping existing data  
# features  
# aws configure (secret, pass, bucket)  
# sync s3 down to /data  
# run import scripts  
RUN \  
mkdir -p /aws && \  
apk --no-cache add groff less python py-pip mysql-client git apk-cron && \  
pip install awscli && \  
apk --purge -v del py-pip  
  
ADD startup.sh /root/  
  
WORKDIR /aws  
#ENTRYPOINT ["aws"]  
CMD ["/root/startup.sh"]  

