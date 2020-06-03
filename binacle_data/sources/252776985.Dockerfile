FROM centos:latest  
MAINTAINER Antoni Segura Puimedon <asegurap@redhat.com>  
  
RUN yum install -y centos-release-openstack-ocata \  
&& yum install -y python-openstackclient python-heatclient sudo \  
&& echo "%users ALL=(ALL:ALL) NOPASSWD: /usr/sbin/useradd" >> /etc/sudoers  
  
RUN echo "%users ALL=(ALL:ALL) NOPASSWD: /usr/bin/openstack" >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_USERNAME"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_PASSWORD"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_AUTH_URL"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_PROJECT_NAME"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_USER_DOMAIN_NAME"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_PROJECT_DOMAIN_NAME"' >> /etc/sudoers  
RUN echo 'Defaults env_keep += "OS_IDENTITY_API_VERSION"' >> /etc/sudoers  
RUN useradd -u 811 -g 100 -M bootstrap  
  
ADD ost_wrapper.sh /usr/local/bin/openstack  
  
USER bootstrap  
ENTRYPOINT ["/usr/local/bin/openstack"]  

