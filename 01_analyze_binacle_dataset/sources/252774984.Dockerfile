FROM debian:jessie  
  
COPY sh/ /build/  
COPY sql/*.sql /  
  
RUN . /build/config.sh && \  
/build/build.sh && \  
/build/clean.sh && \  
/build/seed.sh && \  
rm -rf /build  
  
COPY docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
EXPOSE 80

