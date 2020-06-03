FROM eeacms/jenkins-slave:3.12  
COPY docker-setup.sh /  
RUN /docker-setup.sh  

