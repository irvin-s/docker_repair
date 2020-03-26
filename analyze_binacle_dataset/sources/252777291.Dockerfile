FROM centos:latest  
MAINTAINER cevich@redhat.com  
ENV container="docker" \  
img_name="venv_centos" \  
seed_workspace="/var/tmp/workspace"  
ENV WORKSPACE="$seed_workspace" \  
ARTIFACTS="$seed_workspace/artifacts"  
ADD ["/${img_name}.dockerfile", "/${img_name}.packages", "/root/"]  
ADD ["install.sh", "venv-cmd-wrap.sh", "/root/bin/"]  
RUN /root/bin/install.sh  
ENTRYPOINT ["/root/bin/venv-cmd-wrap.sh"]  

