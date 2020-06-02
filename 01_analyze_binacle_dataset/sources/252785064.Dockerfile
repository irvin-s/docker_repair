FROM coding4m/dnswall  
MAINTAINER coding4m@gmail.com  
  
ENV DNSWALL_DOCKER_URL 'unix:///var/run/docker.sock'  
ENV DNSWALL_BACKEND ''  
ENTRYPOINT ["/usr/local/bin/dnswall-agent"]

