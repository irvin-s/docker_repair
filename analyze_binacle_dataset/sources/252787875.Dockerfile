FROM ubuntu  
ADD megacli_8.07.08-1_all.deb /tmp/  
RUN apt-get update && apt-get install -y dmidecode  
RUN dpkg -i /tmp/megacli_8.07.08-1_all.deb  
ADD check_megaraid /usr/local/bin/  
ENTRYPOINT ["/usr/local/bin/check_megaraid"]  
CMD ["--newline"]  

