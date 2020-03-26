FROM anishitani/docker-ansible  
  
MAINTAINER André Nishitani <andre.nishitani@gmail.com>  
  
ADD postgis.yml /tmp/  
  
WORKDIR /tmp  
  
RUN ansible-galaxy install atoshio25.postgis && \  
ansible-playbook -i "localhost," -c local postgis.yml  
  
EXPOSE 5432  
CMD 'service postgresql start && /bin/bash'  

