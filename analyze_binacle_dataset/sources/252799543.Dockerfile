FROM scratch  
  
ENV RANCHER_URL http://localhost:8080  
ENV RANCHER_ACCESS_KEY undefined  
ENV RANCHER_SECRET_KEY undefinend  
ENV ICINGA_URL http://localhost:5665  
ENV ICINGA_USER undefined  
ENV ICINGA_PASSWORD undefined  
  
ENV RANCHER_SERVERS undefined  
  
ENV ENVIRONMENT_NAME_TEMPLATE "{{.RancherEnvironment}}"  
ENV STACK_NAME_TEMPLATE "[{{.RancherEnvironment}}] {{.RancherStack}}"  
ENV SERVER_CHECK_COMMAND hostalive  
ENV HOST_CHECK_COMMAND hostalive  
ENV STACK_CHECK_COMMAND check_rancher_stack  
ENV SERVICE_CHECK_COMMAND check_rancher_service  
ENV RANCHER_INSTALLATION default  
ENV ICINGA_DEFAULT_VARS ""  
ENV REFRESH_INTERVAL 0  
ENV ICINGA_DEBUG ""  
ENV ICINGA_INSECURE_TLS ""  
ENV FILTER_HOSTS ""  
ENV FILTER_STACKS ""  
ENV FILTER_SERVICES ""  
ADD rancher-icinga /rancher-icinga  
CMD ["/rancher-icinga"]  

