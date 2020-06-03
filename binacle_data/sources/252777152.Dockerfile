FROM progrium/busybox:latest  
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>  
  
ENV WORD_COUNT=1  
RUN opkg-install coreutils-shuf  
COPY words.txt /  
  
CMD shuf -n $WORD_COUNT /words.txt  

