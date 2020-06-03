FROM centos:7  
# install software  
RUN yum -y update &&\  
yum -y install git &&\  
yum -y install java-1.8.0-openjdk-devel &&\  
yum -y install maven &&\  
yum -y install gpg &&\  
yum clean all  
  
# list installed versions  
RUN echo Installed Versions &&\  
echo GIT: &&\  
git --version &&\  
echo JAVA: &&\  
java -version &&\  
echo MAVEN: &&\  
mvn --version &&\  
echo GPG: &&\  
gpg --version  
  
# configure maven  
ENV MAVEN_HOME /usr/share/maven  
RUN rm $MAVEN_HOME/conf/settings.xml  
ADD maven/settings.xml $MAVEN_HOME/conf/settings.xml  
  
# configure GPG  
RUN mkdir -p /root/.gnupg  
ADD gpg/* /root/.gnupg/  
  

