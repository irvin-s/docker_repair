  
FROM python:alpine  
  
RUN apk upgrade -U && \  
apk add --no-cache \  
ca-certificates \  
jpeg-dev \  
gcc \  
musl-dev \  
postgresql-dev \  
ffmpeg \  
sox \  
su-exec && \  
rm -rf /var/cache/*  
  
RUN pip install psycopg2  
RUN pip install requests  
RUN pip install mutagen  
RUN pip install wave  
RUN pip install pillow  
RUN pip install raven  
  
RUN apk del gcc musl-dev  
  
COPY entrypoint.sh /usr/local/bin/entrypoint.sh  
  
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  

