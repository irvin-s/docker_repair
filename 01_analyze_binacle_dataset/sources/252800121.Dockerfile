FROM jenkins  
MAINTAINER "Franco Salonia" <franco.salonia@dinocloudconsulting.com>  
  
USER root  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
graphviz \  
npm \  
&& rm -rf /var/lib/apt/lists/*  
USER jenkins  
  
COPY plugins-master.txt /usr/share/jenkins/plugins.txt  
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt  
  
ENV JAVA_OPTS="-Xmx2048m -Djenkins.install.runSetupWizard=false"  
COPY startup.groovy /usr/share/jenkins/ref/init.groovy.d/startup.groovy  

