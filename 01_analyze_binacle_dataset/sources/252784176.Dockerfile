FROM continuumio/miniconda  
  
MAINTAINER Birdhouse <wps@dkrz.de>  
LABEL Description="Slurm" Vendor="Birdhouse" Version="0.7.6"  
  
# install ansible  
RUN conda install -c conda-forge ansible  
  
# get ansible  
WORKDIR /opt  
RUN git clone https://github.com/bird-house/birdhouse-ansible.git  
  
# run ansible  
WORKDIR /opt/birdhouse-ansible/slurm  
RUN ansible-playbook -e slurm_server_name=slurm playbooks/slurm.yml  
  
# copy start script  
ADD start-services.sh /etc/start-services.sh  
RUN chmod +x /etc/start-services.sh  
  
# ports  
EXPOSE 6817 6818  
# Start service ...  
ENTRYPOINT ["/etc/start-services.sh"]  
CMD ["slurmctld", "slurmd"]  

