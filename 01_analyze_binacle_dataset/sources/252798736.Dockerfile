FROM jenkins/jenkins  
USER root  
ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /  
RUN tar -xzf docker-latest.tgz && rm docker-latest.tgz && \  
mv docker/docker /usr/local/bin && rm -rf docker  
COPY jenkins-docker.sh /usr/local/bin/  
ENTRYPOINT ["/sbin/tini", "--", "jenkins-docker.sh"]  

