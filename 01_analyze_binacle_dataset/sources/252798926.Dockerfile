FROM wurstmeister/kafka:0.10.2.1  
ADD wait-for-zookeeper.sh /usr/bin/wait-for-zookeeper.sh  
RUN chmod a+x /usr/bin/wait-for-zookeeper.sh  
CMD ["wait-for-zookeeper.sh"]  

