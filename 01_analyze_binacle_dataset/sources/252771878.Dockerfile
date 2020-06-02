FROM sentry:onbuild  
RUN cat conf.py >> $SENTRY_CONF/sentry.conf.py  
  

