FROM bconnect/gitlab-base:1.2  
RUN composer global require phing/phing pear/versioncontrol_git:"dev-master"  
COPY runner.sh /runner.sh  
ADD build.xml /build.xml  
ADD ssh_config /etc/ssh/ssh_config  
CMD ["/runner.sh"]  

