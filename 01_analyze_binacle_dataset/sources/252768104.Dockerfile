FROM anapsix/alpine-java:8  
MAINTAINER Akhyar Amarullah <akhyrul@gmail.com>  
  
RUN apk --no-cache add openssl wget  
  
WORKDIR /jenkins-cli  
COPY jenkins-cli-wrapper.sh .  
  
ENV JENKINS_URL ""  
ENV PRIVATE_KEY "/ssh/id_rsa"  
VOLUME /ssh  
  
ENTRYPOINT ["./jenkins-cli-wrapper.sh"]  
CMD ["help"]  

