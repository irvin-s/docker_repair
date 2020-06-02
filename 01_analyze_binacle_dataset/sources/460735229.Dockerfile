FROM jenkinsci/jenkins
RUN /usr/local/bin/install-plugins.sh git workflow-aggregator 
USER root
RUN apt-get install curl unzip
RUN curl -o apc.zip http://api.demo.apcera.net/v1/apc/download/linux_amd64/apc.zip
RUN unzip apc.zip -d /usr/local/bin/
