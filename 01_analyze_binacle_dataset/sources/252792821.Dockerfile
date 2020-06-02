# Run options can be specified at container start time or interactively  
# schedule - Start-up only: Sets the schedule, starts cron and leaves  
# container running. (default)  
# backup - Runs a backup now.  
# Start-up: Runs a backup and stops container when the backup  
# completes.  
# Interactive: Backup will run now without changing exisitng  
# schedule, then drops to a shell.  
# Backup sets a lock file and checks for existing lock file before running  
# a backup.  
FROM alpine:latest  
  
MAINTAINER Mark Chester <mark@chestersgarage.com>  
  
RUN apk --no-cache add python py-pip  
RUN pip install awscli  
RUN rm -rf /tmp/pip_build_root/  
  
RUN mkdir -p /data  
  
ADD s3backup.sh /  
  
ENTRYPOINT ["/bin/sh","/s3backup.sh"]  
CMD ["schedule"]  
  

