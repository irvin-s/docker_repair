FROM cameronbrunner/tinycorelinux-extensions:submit  
# Need the openssl package to get certificate bundle  
RUN tce-load -wci openssl  
COPY build-rsync.sh /scratch/  
COPY rsync.tcz.info.tmpl /scratch/  
USER tc  
CMD ["/bin/sh", "-c", "cd /scratch; /bin/sh ./build-rsync.sh"]  

