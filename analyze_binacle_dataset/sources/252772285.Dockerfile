FROM perl:5.24  
RUN cpanm -v Stor  
  
ENTRYPOINT ["hypnotoad", "--foreground", "/usr/local/bin/stor"]  

