FROM cocoon/ivatools  
MAINTAINER cocoon  
  
RUN apt-get update && apt-get clean  
RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean  
ADD http://mirrors.jenkins-ci.org/war/1.578/jenkins.war /opt/jenkins.war  
RUN chmod 644 /opt/jenkins.war  
  
#ADD requirements.txt /tmp/  
#RUN pip install -r /tmp/requirements.txt  
#RUN rm /tmp/requirements.txt  
# need volumes: /jenkins for the state , /tests for the test sources  
ENV JENKINS_HOME /jenkins  
ENV TESTS_HOME /tests  
  
  
  
EXPOSE 8080  
CMD ["java", "-jar", "/opt/jenkins.war"]

