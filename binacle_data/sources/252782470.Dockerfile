FROM ckulka/rhodecode-rccontrol:1.16.0  
LABEL maintainer="cyrill.kulka@gmail.com"  
  
ENV RC_APP VCSServer  
ENV RC_VERSION 4.10.5  
RUN .rccontrol-profile/bin/rccontrol \  
install VCSServer \  
\--version $RC_VERSION \  
\--accept-license \  
'{"host": "0.0.0.0", "port": 9900}'  
  
EXPOSE 9900  
CMD bash ./start.sh  

