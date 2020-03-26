FROM node:9  
COPY . /usr/src/app/  
RUN cd /usr/src/app/ && npm install  
  
ENV HOST=localhost  
ENV PORT=9200  
ENV SCHEMA=http  
ENV PREFIX=logstash-  
ENV DAYS=7  
ENV CRON="0 1 * * * *"  
ENTRYPOINT cd /usr/src/app/ && node index.js \  
\--elasticsearch:schema ${SCHEMA} \  
\--elasticsearch:host ${HOST} \  
\--elasticsearch:port ${PORT} \  
\--logstash:indexPrefix ${PREFIX} \  
\--logstash:keepLatestDays ${DAYS} \  
\--cronExpr "${CRON}"  

