FROM kibana:4.5  
RUN /opt/kibana/bin/kibana plugin --install elastic/sense/latest \  
&& chown -R kibana:kibana /opt/kibana  
  
EXPOSE 5601  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["kibana"]  

