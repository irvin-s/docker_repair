FROM progrium/busybox:latest  
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>  
  
RUN opkg-install perl  
  
CMD perl -ne 'chomp;print scalar reverse . "\n";'  

