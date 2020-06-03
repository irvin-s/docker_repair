FROM telegraf:latest  
  
ADD telegraf.conf /etc/telegraf/telegraf.conf  
ADD telegraf.conf.sample /etc/telegraf/telegraf.conf.sample  

