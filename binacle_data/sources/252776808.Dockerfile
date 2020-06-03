FROM ccfoss/alpine-consul  
Maintainer Chaitanya Akkineni cakkinen@cisco.com  
  
EXPOSE 8500  
ADD agent_base_config.json.ctmpl /tmp/  
ADD consul-template.hcl /etc/consul.d/  
  
CMD ["consul", "agent", "-config-dir", "/etc/consul.d"]

