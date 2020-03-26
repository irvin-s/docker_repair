FROM fedora:25  
MAINTAINER bradley leonard <bradley@leonard.pub>  
  
# install net-tools, required for serverspec to check ports  
# install calibre  
RUN dnf clean all && dnf -y install procps-ng calibre  
  
# create directories  
RUN mkdir /data && mkdir /scripts  
  
# add startup.sh  
ADD startup.sh /scripts/startup.sh  
RUN chmod 755 /scripts/startup.sh  
  
# add add-books.sh  
ADD add-books.sh /scripts/add-books.sh  
RUN chmod 755 /scripts/add-books.sh  
  
# add remove-books.sh  
ADD remove-books.sh /scripts/remove-books.sh  
RUN chmod 755 /scripts/remove-books.sh  
  
# Expose port  
EXPOSE 8080  
CMD ["/scripts/startup.sh"]  

