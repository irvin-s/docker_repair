FROM zotonic/zotonic:0.x  
  
ENV LOGSTASH_HOST 127.0.0.1  
ENV LOGSTASH_PORT 5514  
ENV JSX_FORCE_MAPS 1  
COPY erlang.config /etc/zotonic/erlang.config  
COPY zotonic.config /etc/zotonic/zotonic.config  
COPY docker-entrypoint-ginger.sh /  
  
RUN apk add --no-cache $BUILD_APKS inotify-tools \  
&& DEBUG=1 make  
  
RUN chown -R zotonic /opt/zotonic/ebin  
  
ENV TERM linux  
  
# Overriding the entrypoint also overrides the cmd  
ENTRYPOINT ["/docker-entrypoint-ginger.sh"]  
CMD ["start-nodaemon"]  

