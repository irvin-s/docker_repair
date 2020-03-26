  
# s2i-apb  
FROM ansibleplaybookbundle/apb-base  
MAINTAINER Ansible Playbook Bundle Community  
  
LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \  
io.openshift.s2i.destination=/tmp \  
io.openshift.tags="builder,apb"  
  
COPY ./s2i/bin/ /usr/libexec/s2i  
  
ENV USER_NAME=apb \  
BASE_DIR=/opt/${USER_NAME}  
ENV HOME=${BASE_DIR}  
  
USER root  
RUN mkdir -p /opt/ansible/roles && \  
mkdir -p ${BASE_DIR}/actions && \  
mkdir -p /tmp/.s2i  
  
RUN chown ${USER_NAME}:0 /opt/ansible/roles && \  
chown ${USER_NAME}:0 ${BASE_DIR}/actions && \  
chown ${USER_NAME}:0 /tmp/.s2i  
  
USER ${USER_NAME}  
RUN chmod g+rw /opt/ansible/roles && \  
chmod g+rw ${BASE_DIR}/actions && \  
chmod a+rw /tmp/.s2i  
  
USER 1001  
  
CMD ["usage"]  

