FROM andmyhacks/trufflehog  
  
COPY \--from=bbvalabsci/buildbot-washer-worker:latest /washer /washer  
CMD ["/washer/entrypoint.sh"]  

