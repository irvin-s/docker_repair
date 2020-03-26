FROM clouder/clouder-base  
MAINTAINER Yannick Buron yburon@goclouder.net  
  
RUN mkdir -p /srv/salt/_modules  
ADD sources/salt-master/base_update.sls /srv/salt/  
ADD sources/salt-master/container_deploy_api.sls /srv/salt/  
ADD sources/salt-master/container_deploy.sls /srv/salt/  
ADD sources/salt-master/container_purge.sls /srv/salt/  
ADD sources/salt-master/container_start.sls /srv/salt/  
ADD sources/salt-master/container_stop.sls /srv/salt/  
ADD sources/_modules/clouder.py /srv/salt/_modules/  
  
RUN mkdir -p /srv/pillar/containers  
RUN mkdir -p /srv/pillar/bases  
RUN echo "base:" > /srv/pillar/top.sls  
CMD ["true"]  

