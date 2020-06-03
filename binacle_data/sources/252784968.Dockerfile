###################  
# Enhances the jenkins official image by installing additional tools:  
#  
# * docker.io package  
#  
# see https://github.com/cloudbees/jenkins-ci.org-docker  
FROM jenkins:1.596.1  
MAINTAINER coderfi@gmail.com  
  
USER root  
  
RUN apt-get update \  
&& apt-get install -y docker.io sudo \  
&& wget -O- https://get.docker.com/ | sh \  
&& usermod -G docker jenkins \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD jenkins-plus.sh /usr/local/bin/jenkins-plus.sh  
RUN chmod a+x /usr/local/bin/jenkins-plus.sh  
ENTRYPOINT ["/usr/local/bin/jenkins-plus.sh"]  
  
# DO NOT set `USER jenkins`  
# The jenkins-plus.sh script requires sufficient privileges  
# to change the docker group id at runtime.  
# The script will run the jenkins webserver as the jenkins user (via sudo).  

