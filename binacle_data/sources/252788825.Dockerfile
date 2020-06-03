FROM centurylink/ca-certs  
MAINTAINER DrinkIn  
ADD data/zoneinfo.zip /zoneinfo.zip  
ENV ZONEINFO /zoneinfo.zip  

