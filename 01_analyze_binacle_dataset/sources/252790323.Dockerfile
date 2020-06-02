FROM capd/baseimage:0.1.2  
MAINTAINER Mateusz Juda <mateusz.juda@{gmail.com,ii.uj.edu.pl}>  
# Based on rfkrocktk/docker-puppet  
ENV HOME /root  
ENV LANG en_US.UTF-8  
RUN locale-gen en_US.UTF-8  
  
# Install the latest stable Puppet client  
RUN apt-get update -q 2 && DEBIAN_FRONTEND=noninteractive \  
apt-get install --yes -q 2 puppet >/dev/null  
  
# Install startup script for adding the cron job  
ADD scripts/50_add_puppet_cron.sh /etc/my_init.d/  
RUN chmod +x /etc/my_init.d/50_add_puppet_cron.sh  
  
# Install actual Puppet agent run command  
ADD scripts/run-puppet-agent.sh /sbin/run-puppet-agent  
RUN chmod +x /sbin/run-puppet-agent && puppet agent --enable  
  
# Use the runit init system.  
CMD ["/sbin/my_init"]  

