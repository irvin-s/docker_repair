FROM payara/micro  
WORKDIR /opt/payara  
COPY target/xavier.war deployments  
  

