FROM jwilder/docker-gen:0.7.3  
MAINTAINER Citus Data https://citusdata.com  
  
RUN apk add --no-cache postgresql-client  
  
ENV CITUS_CONFDIR=/etc/citus  
  
VOLUME $CITUS_CONFDIR  
  
COPY workerlist-entrypoint.sh pg_worker_list.tmpl /  
  
ENTRYPOINT ["/workerlist-entrypoint.sh"]  

