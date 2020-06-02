FROM anapsix/alpine-java:7  
MAINTAINER Akhyar Amarullah <akhyrul@gmail.com>  
  
WORKDIR /jenkins-cli  
COPY jenkins-cli-wrapper.sh .  
  
ENV JENKINS_URL ""  
ENV PRIVATE_KEY "/ssh/id_rsa"  
VOLUME /ssh  
  
ENTRYPOINT ["./jenkins-cli-wrapper.sh"]  
CMD ["help"]  

