FROM semtech/mu-ruby-template:1.3.1-ruby2.1  
MAINTAINER Erika Pauwels <erika.pauwels@gmail.com>  
MAINTAINER Aad Versteden <madnificent@gmail.com>  
  
ENV CHECK_HEALTH_STATUS true  
ENV DEFAULT_STEP_STATUS_WHEN_HEALTHY ready  
ENV DEFAULT_STEP_STATUS_WHEN_UNHEALTHY failed  
# ONBUILD of mu-ruby-template takes care of everything

