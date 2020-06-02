FROM christopwner/netsuite-cli:latest  
  
LABEL description="NetSuite SDF CLI with SonarQube"  
LABEL version="2017.2.0"  
  
ADD sonar-scanner-3.0.3.778/ /opt/sonar-scanner/  
ENV PATH "$PATH:/opt/sonar-scanner/bin"  
CMD sh sdfcli -h  

