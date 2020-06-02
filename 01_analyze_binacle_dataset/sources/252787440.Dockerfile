FROM telegraf  
  
ENV INFLUX_URL= \  
INFLUX_DB=telegraf \  
INFLUX_USER= \  
INFLUX_PASS=  
  
COPY telegraf.conf etc/telegraf/telegraf.conf  

