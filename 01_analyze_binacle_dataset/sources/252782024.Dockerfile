FROM sebp/elk  
ADD ./03-udp-input.conf /etc/logstash/conf.d/03-udp-input.conf  
CMD [ "/usr/local/bin/start.sh" ]  

