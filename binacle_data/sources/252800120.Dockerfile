FROM ubuntu:trusty  
MAINTAINER Franco Salonia (franco.salonia@dinocloudconsulting.com)  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
# Install Ansible  
RUN apt-get update -qy && \  
apt-get install -qy software-properties-common && \  
apt-add-repository -y ppa:ansible/ansible && \  
apt-get update -qy && \  
apt-get install -qy ansible  
  
COPY ansible /ansible  
  
# Add volume for Ansible playbooks  
VOLUME /ansible  
WORKDIR /ansible  
  
# Entrypoint  
ENTRYPOINT ["ansible-playbook"]  
CMD ["site.yml"]  

