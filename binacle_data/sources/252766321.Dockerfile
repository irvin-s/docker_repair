FROM busybox:latest  
  
# -- copy additional OS level packages to be installed at user level  
COPY packages/* /usr/share/jenkins/sidekick/packages/  
  
# -- copy the init script that will be the new entrypoint for jenkins-master  
COPY jenkins-init.sh /usr/share/jenkins/sidekick/jenkins-init.sh  
# -- set executable flag  
RUN chmod +x /usr/share/jenkins/sidekick/jenkins-init.sh  
  
# -- copy default set of plugins to be installed  
COPY plugins.txt /usr/share/jenkins/sidekick/plugins.txt  
  
# -- copy initial configuration files  
COPY config/* /usr/share/jenkins/sidekick/config/  
  
# -- later add other seutp scripts to config/init.groovy.d  
COPY init.groovy.d/* /usr/share/jenkins/sidekick/init.groovy.d/  
  
# -- expose the volume to jenkins-master  
VOLUME /usr/share/jenkins/sidekick  

