FROM python:3-onbuild  
ENV OS_AUTH_URL=https://identity.api.rackspacecloud.com/v2.0/ \  
OS_USERNAME= \  
OS_PASSWORD= \  
OS_PROJECT_ID=  
  
ENTRYPOINT ["/usr/local/bin/openstack"]  
CMD ["--help"]  

