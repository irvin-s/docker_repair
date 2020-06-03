FROM python:2.7  
RUN pip install ansible lxml docker-py  
RUN pip install -U requests==2.5.3  
RUN apt-get update -qq && \  
apt-get install -qqy unzip \  
apt-transport-https \  
ca-certificates \  
curl \  
lxc \  
iptables  
  
# Install Docker from Docker Inc. repositories.  
RUN curl -sSL https://get.docker.com/ | sh  
  
RUN mkdir -p /ansible/playbooks  
WORKDIR /ansible/playbooks  
  
ENV ANSIBLE_GATHERING smart  
ENV ANSIBLE_HOST_KEY_CHECKING false  
ENV ANSIBLE_RETRY_FILES_ENABLED false  
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles  
ENV ANSIBLE_SSH_PIPELINING True  
ENV PATH /ansible/bin:$PATH  
ENV PYTHONPATH /ansible/lib  
  
ENTRYPOINT ["ansible-playbook"]  

