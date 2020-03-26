FROM prom/prometheus:v2.1.0  
USER root  
  
ADD /rules/*.rules /infra-server-rules/  
ADD /infra-server-rules.yml /  
COPY /docker-entrypoint.sh /  
  
RUN promtool check rules /infra-server-rules/*.rules  
  
VOLUME ["/infra-server-rules/"]  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/bin/cp", "-f", "/infra-server-rules.yml", "/etc/prometheus/conf.d/"]  

