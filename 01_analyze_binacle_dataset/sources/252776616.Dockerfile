FROM ubuntu:latest  
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>  
  
# Install dependencies  
RUN apt-get update \  
&& apt-get install wget cron mysql-client gzip -y \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install S3  
RUN cd /tmp  
RUN wget https://github.com/barnybug/s3/releases/download/1.1.4/s3-linux-amd64  
RUN mv s3-linux-amd64 s3 && chmod +x s3 && mv s3 /usr/local/bin/s3  
  
# Create the log file to be able to run tail  
RUN touch /var/log/cron.log  
  
# Execute cron  
ENTRYPOINT crontab /etc/cron.d/cron-job && cron  
# Run the command on container startup  
CMD tail -f /var/log/cron.log  

