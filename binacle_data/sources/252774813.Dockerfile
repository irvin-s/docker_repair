FROM jenkinsci/jenkins:2.32.3  
MAINTAINER Baptiste Mathus <batmat@batmat.net>  
  
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"  
COPY init_scripts/*.groovy /usr/share/jenkins/ref/init.groovy.d/  
  
# The plugins I want installed  
RUN /usr/local/bin/install-plugins.sh \  
workflow-aggregator:2.5 \  
pipeline-stage-view:2.6 \  
workflow-multibranch:2.13 \  
pipeline-utility-steps:1.2.2 \  
pipeline-model-definition:1.0.2 \  
github-branch-source:2.0.4 \  
ssh-agent:1.14 \  
blueocean:1.0.0-b25 \  
blueocean-pipeline-editor:1.0-alpha-4 \  
pipeline-maven:2.0-beta-6  
  
# the plugins I maintain  
RUN /usr/local/bin/install-plugins.sh \  
buildtriggerbadge:2.8 \  
radiatorviewplugin:1.29 \  
chucknorris:1.0 \  
parameterized-scheduler:0.2 \  
extended-read-permission:2.0 \  
versioncolumn  

