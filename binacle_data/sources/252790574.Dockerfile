FROM guywithnose/sqlplus  
MAINTAINER Carlos Castillo Alarcón  
  
RUN mkdir /usr/network  
COPY admin /usr/network/admin  
ENV TNS_ADMIN /usr/network/admin  
  
COPY workdir /usr/workdir  
  
VOLUME ["/usr/network/admin"]  
VOLUME ["/usr/workdir"]  
  
ENV USERNAME scott  
ENV NET_SERVICE_NAME XE  
ENV EDITOR=vi  
ENV NLS_LANG SPANISH_SPAIN.WE8MSWIN1252  
ENV ORA_SDTZ Europe/Madrid  
  
WORKDIR "/usr/workdir"  
  
CMD sqlplus "${USERNAME}@${NET_SERVICE_NAME}"  

