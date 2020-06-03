FROM jenkins/jenkins:lts

USER root

# Enable passwordless sudo for jenkins and set timezone
RUN echo "Etc/UTC" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Create log directory
RUN mkdir -p /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

# Create cache directory
RUN mkdir -p /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

USER jenkins

# Enable STARTTLS
ENV JAVA_OPTS "-Djava.awt.headless=true -Dmail.smtp.starttls.enable=true"

# Enable HTTPs for the web interface
ENV JENKINS_OPTS "--logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --httpPort=8080"
