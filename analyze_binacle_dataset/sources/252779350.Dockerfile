FROM debian:jessie-slim  
  
RUN apt-get update && apt-get install -y cron python-pip  
RUN pip install awscli  
  
RUN apt-get install -y mysql-client  
  
ADD backup /  
ADD restore /  
ADD cron /  
ADD wait /  
  
RUN chmod +x backup  
RUN chmod +x restore  
RUN chmod +x cron  
RUN chmod +x wait  
  
CMD ["./cron"]

