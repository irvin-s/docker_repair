FROM dakku/drupal-vm-autobuild:latest  
LABEL maintainer="Dakku Singh"  
  
# Copy provisioning directory, variable overrides, and scripts into container.  
COPY ./docker-hub-overrides.yml /etc/ansible/drupal-vm/local.config.yml  
  
# Provision Drupal VM inside Docker.  
RUN ansible-playbook /etc/ansible/drupal-vm/provisioning/playbook.yml  
  
WORKDIR "/var/www/html"  

