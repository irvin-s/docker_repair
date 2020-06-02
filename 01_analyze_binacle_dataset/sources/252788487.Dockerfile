FROM crux:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
ENV LOCALE en_US  
ENV LC_ALL en_US.utf-8  
  
RUN mv /etc/ports/contrib.rsync.inactive /etc/ports/contrib.rsync && \  
sed -i -e "s|^#prtdir /usr/ports/contrib|prtdir /usr/ports/contrib|" \  
/etc/prt-get.conf && \  
sed -i -e "s|^# readme.*$|readme verbose|" \  
/etc/prt-get.conf && \  
sed -i -e "s|^# preferhigher.*$|preferhigher yes|" \  
/etc/prt-get.conf && \  
sed -i -e "s|^# runscripts.*$|runscripts yes|" \  
/etc/prt-get.conf  
  
RUN localedef -i ${LOCALE} -f ISO-8859-1 ${LOCALE} && \  
localedef -i ${LOCALE} -f ISO-8859-1 ${LOCALE}.ISO-8859-1 && \  
localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.utf8  
  
RUN ports -u && prt-get cache  

