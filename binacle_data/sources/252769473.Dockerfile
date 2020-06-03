FROM ansibleplaybookbundle/apb-base  
  
RUN yum install -y jq && yum clean all  
  
USER apb  
  
COPY helm /bin/helm  
COPY entrypoint.sh /usr/bin/hbb-entrypoint.sh  
  
ENTRYPOINT ["hbb-entrypoint.sh"]  

