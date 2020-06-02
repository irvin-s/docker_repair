FROM telegraf:alpine  
RUN apk update && apk add net-snmp-tools iputils  

