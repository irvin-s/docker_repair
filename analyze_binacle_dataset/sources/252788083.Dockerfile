FROM crazymanjinn/zfs-utils  
  
RUN apt-get update && apt-get -y install cron && \  
rm -rf /var/lib/apt/lists/*  
  
COPY cronhelper.sh /opt/bin/cronhelper.sh  
ENTRYPOINT ["/opt/bin/cronhelper.sh"]  
CMD ["0 3 * * 0", "zpool1"]  

