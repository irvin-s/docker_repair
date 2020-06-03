FROM desiato/archlinux  
COPY build.sh /usr/local/bin/  
VOLUME /output  
CMD build.sh

