FROM adamoss/kali2-base  
####################################################  
# YOU CAN USE officialkali/kali:2.0 if you wish ##  
####################################################  
MAINTAINER Adam Ossenford <AdamOssenford@gmail.com>  
####################################################  
# INSERT OUR LAUNCH ENTRY POINT SCRIPT  
####################################################  
COPY launch.sh /usr/bin/launch.sh  
####################################################  
# UPDATE APT AND INSTALL THE METASPLOIT FRAMEWORK  
####################################################  
RUN apt-get update -y && \  
apt-get install metasploit-framework -y && \  
msfupdate && \  
rm /usr/share/metasploit-framework/data/logos/*.txt && \  
chmod 755 /usr/bin/launch.sh  
####################################################  
# CUSTOMIZE METASPLOIT BANNER TO SOMETHING SECKC  
####################################################  
COPY seckc-docker.txt /usr/share/metasploit-framework/data/logos/cowsay.txt  
  
ENTRYPOINT ["/usr/bin/launch.sh"]  

