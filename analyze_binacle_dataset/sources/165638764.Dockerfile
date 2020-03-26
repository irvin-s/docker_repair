FROM jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# remove executors in master
COPY master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/
