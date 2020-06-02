# Name: kalibase  
# Version: 0.1.4  
# Desc: Kali image plus basic infosec tools  
FROM kalilinux/kali-linux-docker:latest  
MAINTAINER Luca Cancelliere "luca.canc@gmail.com"  
SHELL ["/bin/bash", "-c"]  
RUN apt-get -y update && \  
apt-get -y install metasploit-framework nmap dnsenum bettercap \  
dnsmap exploitdb masscan theharvester wireshark sqlmap mitmproxy \  
commix shellnoob set wordlists webshells weevely dnsutils sslstrip \  
patator hydra joomscan vim git cryptcat && \  
apt-get autoremove && rm -rf /var/lib/apt/lists/*  
#Start Posgress for init msf and build caches  
RUN /etc/init.d/postgresql start && msfdb init && \  
msfconsole -q -x "db_rebuild_cache; exit"  
ADD ["scripts/msfstart", "/usr/local/bin/msfstart"]  
WORKDIR /root  
CMD ["/bin/bash"]  

