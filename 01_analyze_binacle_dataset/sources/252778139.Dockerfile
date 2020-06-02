FROM prom/prometheus  
MAINTAINER Lukas Loesche <lloesche@fedoraproject.org>  
EXPOSE 9093  
EXPOSE 9090  
ADD prometheus.yml /etc/prometheus/  
ADD prometheus.rules /etc/prometheus/  
ADD mkalertmanagercfg /bin/mkalertmanagercfg  
ADD startup /  
ADD external/dumb-init_1.2.0_amd64 /bin/dumb-init  
ADD external/srv2file_sd /bin/srv2file_sd  
ADD external/alertmanager-0.5.1.linux-amd64 /bin/alertmanager  
RUN chmod +x /startup /bin/dumb-init /bin/srv2file_sd /bin/alertmanager  
  
ENTRYPOINT [ "/bin/dumb-init", "--" ]  
CMD ["/startup"]  

