FROM postgres:9.3  
  
MAINTAINER Jérémy Jacquier-Roux <jeremy.jacquier-roux@bonitasoft.org>  
  
# install patch  
RUN apt-get update && apt-get install -y patch  
COPY docker-entrypoint.sh.patch /  
# apply patch to set max_prepared_transactions to 100  
RUN patch docker-entrypoint.sh < docker-entrypoint.sh.patch  
# remove patch  
RUN apt-get purge -y patch && apt-get clean -y && apt-get autoremove -y  

