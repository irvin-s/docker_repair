FROM apache/zeppelin:0.7.3  
COPY interpreter.json /zeppelin/conf/interpreter.json  
COPY zeppelin-site.xml.template /zeppelin/conf/zeppelin-site.xml  
COPY RunConfiguredZeppelin.sh /zeppelin/RunConfiguredZeppelin.sh  
RUN chmod +x /zeppelin/RunConfiguredZeppelin.sh  
CMD ["/zeppelin/RunConfiguredZeppelin.sh"]  

