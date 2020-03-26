FROM ubuntu:16.04  
LABEL maintainer="Kyle Lindeque"  
  
# Install dependencies  
RUN apt-get update  
RUN apt-get install -y --no-install-recommends \  
python-software-properties \  
software-properties-common \  
rsyslog systemd systemd-cron sudo  
  
# Add and update again for Ansible  
RUN add-apt-repository -y ppa:ansible/ansible  
RUN apt-get update  
  
# Install Ansible  
RUN apt-get install -y --no-install-recommends ansible  
  
# Clean Up  
RUN rm -rf /var/lib/apt/lists/*  
RUN rm -Rf /usr/share/doc && rm -Rf /usr/share/man  
RUN apt-get clean  
  
# Logging  
RUN sed -i 's/^\\($ModLoad imklog\\)/#\1/' /etc/rsyslog.conf  
  
# Install Ansible inventory file  
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts  

