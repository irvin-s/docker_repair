FROM scratch  
ADD c7-docker.tar.xz /  
LABEL name="CentOS Base Image" \  
vendor="CentOS" \  
license="GPLv2" \  
build-date="2015-12-23"  
# Volumes for systemd  
# VOLUME ["/run", "/tmp"]  
# Environment for systemd  
# ENV container=docker  
# For systemd usage this changes to /usr/sbin/init  
# Keeping it as /bin/bash for compatability with previous  
CMD ["/bin/bash"]  
USER 1000  

