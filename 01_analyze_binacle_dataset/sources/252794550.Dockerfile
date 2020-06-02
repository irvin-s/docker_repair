FROM datakurre/nix  
MAINTAINER asko.soukka@iki.fi  
COPY build.sh /home/user/  
ENTRYPOINT ["/home/user/build.sh"]  

