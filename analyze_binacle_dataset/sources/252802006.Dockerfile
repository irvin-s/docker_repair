FROM jenkins/jenkins:2.107.2  
  
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt  
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt  
ENV HOME $JENKINS_HOME  
  
USER root  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends graphviz nodejs \  
&& rm -rf /var/lib/apt/lists/*  
USER ${user}  

